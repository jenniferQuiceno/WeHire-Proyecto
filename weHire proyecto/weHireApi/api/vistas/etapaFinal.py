import json
import os
from uuid import uuid4
from django.http.response import JsonResponse
from django.views import View
from ..models import EtapaFinal, Publicaciones, Usuarios
from django.utils.decorators import method_decorator
from django.views.decorators.csrf import csrf_exempt
from ..vistas.correos import enviar_correo

class EstapaFinalView(View):
    @method_decorator(csrf_exempt)
    def dispatch(self, request, *args, **kwargs):
        return super().dispatch(request, *args, **kwargs)
    
    def get(self,request, id=0):
        if(id>0):
            etapafinal= list(EtapaFinal.objects.filter(id=id).values())
            if len(etapafinal)>0:
                etapafinal= etapafinal[0]
                datos= {'message': "Success",'etapa_final': etapafinal}
            else:  
                datos={'message': "No hay etapa"}
            return JsonResponse(datos)
        else:
            etapasFinales = list(EtapaFinal.objects.values())
            if len(etapasFinales)>0:
                datos= {'message': "Success","etapa_final":etapasFinales}
            else:
                datos= {'message': "Etapa final  no encontrada"}
            return JsonResponse(datos)
   
    def post(self,request,action):
        try:
            if action == 'REGISTRAR':
                try:    
                    data = json.loads(request.body)
                    usuario_id = data.get('usuario_id')
                    publicacion_id = data.get('publicacion_id')
                    estado = data.get('estado')
                    observaciones = data.get('observaciones')
                    retroalimentacion = data.get('retroalimentacion')
                    archivo = data.get('archivo')
            
                    if not usuario_id or not publicacion_id:
                        return JsonResponse({'message': 'Datos incompletos'}, status=400)

                    usuario = Usuarios.objects.filter(id=usuario_id).first()
                    if not usuario:
                        return JsonResponse({'message': 'Usuario no encontrado'}, status=404)

                    publicacion = Publicaciones.objects.filter(id=publicacion_id).first()
                    if not publicacion:
                        return JsonResponse({'message': 'Publicación no encontrada'}, status=404)

                    EtapaFinal.objects.create(
                        estado=estado, 
                        usuario=usuario,
                        publicacion=publicacion,
                        observaciones=observaciones,
                        archivo=archivo,
                        retroalimentacion=retroalimentacion
                    )
                    return JsonResponse({'message': 'Etapa final registrada'}, status=201)       
                except Exception as e:
                    datos = {'message': f'Error al registrar etapa final: {str(e)}'}
                    return JsonResponse(datos, status=500)
            elif action == 'ACTUALIZAR':
                    nombreArchivo = None
                    if 'archivo' in request.FILES:
                        nombreArchivo = self.guardar_archivo(request.FILES.get('archivo'))
                        
                    etapaFinal= list(EtapaFinal.objects.filter(id=request.POST.get('id')).values())
                    if len(etapaFinal)>0:  
                        usuario= Usuarios.objects.filter(id=request.POST.get('usuario_id')).first()
                        etapaFinal =EtapaFinal.objects.get(id=request.POST.get('id'))
                        estado_original = etapaFinal.estado
                        
                        etapaFinal.estado=request.POST.get('estado') if request.POST.get('estado') != None else etapaFinal.estado
                        
                        etapaFinal.observaciones=request.POST.get('observaciones') if request.POST.get('observaciones') != None else etapaFinal.observaciones
                        etapaFinal.usuario=usuario
                        etapaFinal.publicacion=request.POST.get('publicacion') if request.POST.get('publicacion') != None else etapaFinal.publicacion
                        etapaFinal.retroalimentacion=request.POST.get('retroalimentacion') if request.POST.get('retroalimentacion') != None else etapaFinal.retroalimentacion 
                        hubo_cambio_estado = estado_original != request.POST.get('estado') 
                        if (nombreArchivo != None and 'archivo' in request.FILES):
                            etapaFinal.archivo = nombreArchivo
                        etapaFinal.save()
                        datos= {'message': "etapa actualizada", "etapa_estado": hubo_cambio_estado}
                        publicacion = Publicaciones.objects.filter(id=request.POST.get('publicacion_id')).first()
                        enviar_correo(request.POST.get('usuario_id'), "Etapa FINAL", etapaFinal.estado, publicacion)
                        return JsonResponse(datos)
                    else:
                        datos= {'message': "No se encuentra la etapa indicada"}
                        return JsonResponse(datos)
        except Exception as e:
            datos = {'message': f'Error al registrar la etapa etapa: {str(e)}'}
            return JsonResponse(datos, status=500)
    def put(self,request,id):
        try:
            etapaFinal= list(EtapaFinal.objects.filter(id=id).values())
            if len(etapaFinal)>0:
                etapaFinal =EtapaFinal.objects.get(id=id)
                etapaFinal.estado=request.POST.get('estado') if request.POST.get('estado') != None else etapaFinal.estado
                etapaFinal.observaciones=request.POST.get('observaciones') if request.POST.get('observaciones') != None else etapaFinal.observaciones
                etapaFinal.archivo=request.FILES['archivo']
                etapaFinal.retroalimentacion=request.POST.get('retroalimentacion') if request.POST.get('retroalimentacion') != None else etapaFinal.retroalimentacion
                etapaFinal.save()
                datos= {'message': "Success"}
            else:
                datos= {'message': "etapa  no encontrado"}
            return JsonResponse(datos)
        except Exception as e:
            datos = {'message': f'Error al registrar etapa final: {str(e)}'}
            return JsonResponse(datos, status=500)
        
    def etapaFinalPorPublicacion(request, idPublicacion):
        etapasFinales = list(EtapaFinal.objects.select_related('usuario', 'publicacion')
        .filter(publicacion_id=idPublicacion)
        .values(
            # Campos del modelo EtapaFinal
            'id', 'estado', 'observaciones', 'archivo', 'retroalimentacion',
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
        if len(etapasFinales)>0:
            datos= {'message': "Success","etapa_final":etapasFinales}
        else:
            datos= {'message': "Etapa no encontrada"}
        return JsonResponse(datos)
    
    @staticmethod
    def guardar_archivo(archivo):
        ruta_absoluta = r"C:/Users/User/Desktop/WeHireAngular/weHire/src/assets/archivos_etapa_final/"
        
     
        if not os.path.exists(ruta_absoluta):
            os.makedirs(ruta_absoluta)
        
        extension = os.path.splitext(archivo.name)[1]
        nuevo_nombre = f"{uuid4()}{extension}" 
        
        ruta_archivo = os.path.join(ruta_absoluta, nuevo_nombre)

        with open(ruta_archivo, 'wb+') as destino:
            for chunk in archivo.chunks():
                destino.write(chunk)
        return nuevo_nombre