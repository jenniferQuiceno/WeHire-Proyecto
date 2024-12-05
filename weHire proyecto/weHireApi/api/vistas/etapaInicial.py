import json
from django.http.response import JsonResponse
from django.views import View
from ..models import EtapaInicial,Usuarios,Publicaciones
from django.utils.decorators import method_decorator
from django.views.decorators.csrf import csrf_exempt
from django.core.exceptions import ObjectDoesNotExist
from ..vistas.correos import enviar_correo


class EstapaInicialView(View):
    @method_decorator(csrf_exempt)
    def dispatch(self, request, *args, **kwargs):
        return super().dispatch(request, *args, **kwargs)
    
    def get(self,request, id=0, action=""):
        if(id>0):
            etapaInicial= list(EtapaInicial.objects.filter(id=id).values())
            if len(etapaInicial)>0:
                etapaInicial= etapaInicial[0]
                datos= {'message': "Success",'etapa_inicial': etapaInicial}
            else:  
                datos={'message': "No se encuentra la etapa"}
            return JsonResponse(datos)
        elif action=="por_id":
            etapasiniciales = EtapaInicial.objects.select_related('usuario', 'publicacion').filter()
            if len(etapasiniciales)>0:
                datos= {'message': "Success","etapa_inicial":etapasIniciales}
            else:
                datos= {'message': "Etapa no encontrada"}
            return JsonResponse(datos)
        else:
            etapasIniciales = list(EtapaInicial.objects.values())
            if len(etapasIniciales)>0:
                datos= {'message': "Success","etapa_inicial":etapasIniciales}
            else:
                datos= {'message': "Etapa no encontrada"}
            return JsonResponse(datos)
   
    def post(self, request,action):
        try:
            if action =="REGISTRAR":   
                data = json.loads(request.body)
                usuario_id = data.get('usuario_id')
                publicacion_id = data.get('publicacion_id')
                estado = data.get('estado')
                observaciones = data.get('observaciones')

                if not usuario_id or not publicacion_id:
                    return JsonResponse({'message': 'Datos incompletos'}, status=400)

                usuario = Usuarios.objects.filter(id=usuario_id).first()
                if not usuario:
                    return JsonResponse({'message': 'Usuario no encontrado'}, status=404)

                publicacion = Publicaciones.objects.filter(id=publicacion_id).first()
                if not publicacion:
                    return JsonResponse({'message': 'Publicación no encontrada'}, status=404)
                
                if EtapaInicial.objects.filter(usuario_id=usuario_id, publicacion_id=publicacion_id).exists():
                    return JsonResponse({'error': 'Ya te has postulado a esta publicación'}, status=400)

                EtapaInicial.objects.create(
                    estado=estado, 
                    usuario=usuario,
                    publicacion=publicacion,
                    observaciones=observaciones
                )
                return JsonResponse({'message': 'Etapa inicial registrada'}, status=201)
            elif action =="ACTUALIZAR":
                 etapaInicial= list(EtapaInicial.objects.filter(id=request.POST.get('id')).values())
                 if len(etapaInicial)>0:  
                        usuario= Usuarios.objects.filter(id=request.POST.get('usuario_id')).first()
                        etapaInicial =EtapaInicial.objects.get(id=request.POST.get('id'))
                        estado_original = etapaInicial.estado
                        
                        etapaInicial.estado=request.POST.get('estado') if request.POST.get('estado') != None else etapaInicial.estado
                        etapaInicial.observaciones=request.POST.get('observaciones') if request.POST.get('observaciones') != None else etapaInicial.observaciones
                        etapaInicial.usuario=usuario
                        etapaInicial.publicacion=request.POST.get('publicacion') if request.POST.get('publicacion') != None else etapaInicial.publicacion
                        hubo_cambio_estado = estado_original != request.POST.get('estado') 
                        etapaInicial.save()
                        datos= {'message': "etapa actualizada", "etapa_estado": hubo_cambio_estado}
                        publicacion = Publicaciones.objects.filter(id=request.POST.get('publicacion_id')).first()
                        enviar_correo(request.POST.get('usuario_id'), "Etapa Inicial", etapaInicial.estado, publicacion)
                        return JsonResponse(datos)
                 else:
                        datos= {'message': "No se encuentra la etapa indicada"}
                        return JsonResponse(datos)
        except Exception as e:
            datos = {'message': f'Error al registrar la etapa etapa: {str(e)}'}
            return JsonResponse(datos, status=500)
    
    def etapaInicialPorPublicacion(request, idPublicacion):
        etapasIniciales = list(EtapaInicial.objects.select_related('usuario', 'publicacion')
        .filter(publicacion_id=idPublicacion)
        .values(
            # Campos del modelo EtapaInicial
            'id', 'estado', 'observaciones',
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
        if len(etapasIniciales)>0:
            datos= {'message': "Success","etapa_inicial":etapasIniciales}
        else:
            datos= {'message': "Etapa no encontrada"}
        return JsonResponse(datos)
    
    def etapaInicialPorId(request, id):
        etapasIniciales = list(EtapaInicial.objects.select_related('usuario', 'publicacion')
        .filter(id=id)
        .values(
            # Campos del modelo EtapaInicial
            'id', 'estado', 'observaciones',
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
        if len(etapasIniciales)>0:
            datos= {'message': "Success","etapa_inicial":etapasIniciales[0]}
        else:
            datos= {'message': "Etapa no encontrada"}
        return JsonResponse(datos)
             
