import json
import os
from uuid import uuid4
from django.http.response import JsonResponse
from django.views import View
from ..models import EtapaMedia,Usuarios,Publicaciones
from django.utils.decorators import method_decorator
from django.views.decorators.csrf import csrf_exempt
from django.core.exceptions import ObjectDoesNotExist
from ..vistas.correos import enviar_correo

class EstapaMediaView(View):
    @method_decorator(csrf_exempt)
    def dispatch(self, request, *args, **kwargs):
        return super().dispatch(request, *args, **kwargs)
    
    def get(self,request, id=0, action=""):
        if(id>0):
            etapaMedia= list(EtapaMedia.objects.filter(id=id).values())
            if len(etapaMedia)>0:
                etapaMedia= etapaMedia[0]
                datos= {'message': "Success",'etapa_media': etapaMedia}
            else:  
                datos={'message': "No se encuentra la etapa"}
            return JsonResponse(datos)
        else:
            etapasMedias = list(EtapaMedia.objects.values())
            if len(etapasMedias)>0:
                datos= {'message': "Success","etapa_media":etapasMedias}
            else:
                datos= {'message': "etapa no encontrada"}
            return JsonResponse(datos)
   
    def post(self, request, action):
        try:
            if action =='REGISTRAR':
                nombreArchivo = None
                if 'archivo' in request.FILES:
                    nombreArchivo = self.guardar_archivo(request.FILES.get('archivo'))
                data = json.loads(request.body)
                usuario_id = data.get('usuario_id')
                publicacion_id = data.get('publicacion_id')
                estado = data.get('estado')
                observaciones = data.get('observaciones')
                #archivo = data.get('archivo')

                if not usuario_id or not publicacion_id:
                    return JsonResponse({'message': 'Datos incompletos'}, status=400)

                usuario = Usuarios.objects.filter(id=usuario_id).first()
                if not usuario:
                    return JsonResponse({'message': 'Usuario no encontrado'}, status=404)

                publicacion = Publicaciones.objects.filter(id=publicacion_id).first()
                if not publicacion:
                    return JsonResponse({'message': 'Publicación no encontrada'}, status=404)

                EtapaMedia.objects.create(
                    estado=estado, 
                    usuario=usuario,
                    publicacion=publicacion,
                    observaciones=observaciones,
                    archivo=nombreArchivo
                )
                return JsonResponse({'message': 'Etapa media registrada'}, status=201)          
            elif action == 'ACTUALIZAR':
                 nombreArchivo = None
                 if 'archivo' in request.FILES:
                    nombreArchivo = self.guardar_archivo(request.FILES.get('archivo'))
                    
                 etapaMedia= list(EtapaMedia.objects.filter(id=request.POST.get('id')).values())
                 if len(etapaMedia)>0:  
                    usuario= Usuarios.objects.filter(id=request.POST.get('usuario_id')).first()
                    etapaMedia =EtapaMedia.objects.get(id=request.POST.get('id'))
                    estado_original = etapaMedia.estado
                    
                    etapaMedia.estado=request.POST.get('estado') if request.POST.get('estado') != None else etapaMedia.estado
                    etapaMedia.observaciones=request.POST.get('observaciones') if request.POST.get('observaciones') != None else etapaMedia.observaciones
                    etapaMedia.usuario=usuario
                    etapaMedia.publicacion=request.POST.get('publicacion') if request.POST.get('publicacion') != None else etapaMedia.publicacion
                    hubo_cambio_estado = estado_original != request.POST.get('estado') 
                    if (nombreArchivo != None and 'archivo' in request.FILES):
                        etapaMedia.archivo = nombreArchivo
                        
                    etapaMedia.save()
                    datos= {'message': "etapa actualizada", "etapa_estado": hubo_cambio_estado}
                    publicacion = Publicaciones.objects.filter(id=request.POST.get('publicacion_id')).first()
                    enviar_correo(request.POST.get('usuario_id'), "Etapa MEDIA", etapaMedia.estado, publicacion)
                    return JsonResponse(datos)
                 else:
                    datos= {'message': "No se encuentra la etapa indicada"}
                    return JsonResponse(datos)
        except Exception as e:
            datos = {'message': f'Error al registrar la etapa etapa: {str(e)}'}
            return JsonResponse(datos, status=500)
        
    def etapaMediaPorPublicacion(request, idPublicacion):
        etapasMedias = list(EtapaMedia.objects.select_related('usuario', 'publicacion')
        .filter(publicacion_id=idPublicacion)
        .values(
            # Campos del modelo EtapaMedia
            'id', 'archivo', 'estado', 'observaciones',
            # Campos del modelo Usuarios relacionado con usuario
            'usuario__id', 'usuario__nombre', 'usuario__apellido', 'usuario__correo',
            'usuario__fecha_nacimiento', 'usuario__telefono', 'usuario__celular',
            'usuario__hoja_vida', 'usuario__rol__id', 'usuario__rol__nombre',
            # Campos del modelo Publicaciones relacionado con publicacion
            'publicacion__id', 'publicacion__titulo', 'publicacion__descripcion',
            'publicacion__salario', 'publicacion__requisitos', 'publicacion__estado',
            'publicacion__reclutador__id', 'publicacion__reclutador__nombre',
            'publicacion__candidato__id', 'publicacion__candidato__nombre'
        ))
        if len(etapasMedias)>0:
            datos= {'message': "Success","etapa_media":etapasMedias}
        else:
            datos= {'message': "Etapa no encontrada"}
        return JsonResponse(datos)
    
    @staticmethod
    def guardar_archivo(archivo):
        ruta_absoluta = r"C:/Users/User/Desktop/WeHireAngular/weHire/src/assets/archivos_etapa_media/"
        
     
        if not os.path.exists(ruta_absoluta):
            os.makedirs(ruta_absoluta)
        
        extension = os.path.splitext(archivo.name)[1]  
        nuevo_nombre = f"{uuid4()}{extension}" 
        
        ruta_archivo = os.path.join(ruta_absoluta, nuevo_nombre)

        with open(ruta_archivo, 'wb+') as destino:
            for chunk in archivo.chunks():
                destino.write(chunk)
        return nuevo_nombre