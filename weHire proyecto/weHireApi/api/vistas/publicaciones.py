import json
from urllib import request
from django.http.response import JsonResponse
from django.views import View
from ..models import EtapaInicial, EtapaMedia, EtapaFinal, Publicaciones
from django.utils.decorators import method_decorator
from django.views.decorators.csrf import csrf_exempt


class PublicacionesView(View):
    @method_decorator(csrf_exempt)
    def dispatch(self, request, *args, **kwargs):
        return super().dispatch(request, *args, **kwargs)
    
    def get(self,request, id=0, action=""):
        if(id>0):
            publicaciones= list(Publicaciones.objects.filter(id=id).values())
            if len(publicaciones)>0:
                publicacion= publicaciones[0]
                datos= {'message': "Success",'publicaciones': publicacion}
            else:  
                datos={'message': "No se encuentra la publicación"}
            return JsonResponse(datos)
        elif action == "":
            publicaciones = list(Publicaciones.objects.values())
            if len(publicaciones)>0:
                datos= {'message': "Success","publicaciones":publicaciones}
            else:
                datos= {'message': "No hay publicaciones"}
            return JsonResponse(datos)
        elif action == "ABIERTAS":
            publicaciones = list(Publicaciones.objects.filter(estado="ABIERTA").values())
            if len(publicaciones)>0:
                datos= {'message': "Success","publicaciones":publicaciones}
            else:
                datos= {'message': "No hay publicaciones"}
            return JsonResponse(datos)
   
    def post(self,request,action):
        try:
            if action =="REGISTRAR":
                try:
                    print(f"Datos recibidos: {request.POST}")
                    Publicaciones.objects.create(
                        titulo=request.POST.get('titulo'),
                        descripcion=request.POST.get('descripcion'),
                        salario=request.POST.get('salario'),
                        requisitos=request.POST.get('requisitos'),
                        estado=request.POST.get('estado'),
                        reclutador_id=request.POST.get('reclutador_id'),
                        candidato_id=request.POST.get('candidato_id')
                    )
                    return JsonResponse({'message': 'UsuPuiblicaicon ario registrado correctamente'}, status=201)
                except Exception as e:
                    print(f"Error al crear publicación: {e}")
                    return JsonResponse({'error': 'Error al registrar publicación'}, status=400)
            elif action == "ACTUALIZAR":
                 publicacion= list(Publicaciones.objects.filter(id=request.POST.get('id')).values())
                 if len(publicacion)>0:
                        publicacion =Publicaciones.objects.get(id=request.POST.get('id'))
                        publicacion.titulo=request.POST.get('titulo') if request.POST.get('titulo') != None else publicacion.titulo
                        publicacion.descripcion=request.POST.get('descripcion') if request.POST.get('descripcion') != None else publicacion.descripcion
                        publicacion.salario=request.POST.get('salario') if request.POST.get('salario') != None else publicacion.salario
                        publicacion.requisitos=request.POST.get('requisitos') if request.POST.get('') != None else publicacion.requisitos
                        publicacion.estado=request.POST.get('estado') if request.POST.get('estado') != None else publicacion.estado
                        publicacion.save()
                        datos= {'message': "Publicación actualizada correctamente"}
                        return JsonResponse({'message': 'Usuario registrado correctamente'}, status=201)
                 else:
                        datos= {'message': "No se encuentra la oublkicación indicada"}
                        return JsonResponse(datos)
        except Exception as e:
            datos = {'message': f'Error la  publicación: {str(e)}'}
            return JsonResponse(datos, status=500)
        
        
        
    def listar_publicaciones_reclutador(request, id):
        publicaciones = Publicaciones.objects.filter(reclutador_id=id)
        print("Publicaciones encontradas:", publicaciones)   
    
        if publicaciones.exists():
            publicaciones_data = list(publicaciones.values('id','titulo', 'descripcion','requisitos','salario', 'estado'))
            print("Datos procesados:", publicaciones_data)       

            return JsonResponse({'publicaciones': publicaciones_data})
        else:
            return JsonResponse({'publicaciones': []}, status=404)

    def listar_mis_postulaciones(request, id):
            etapaInicial =  list(EtapaInicial.objects.select_related('usuario', 'publicacion')
            .filter(usuario_id=id)
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
                'publicacion__candidato__id', 'publicacion__candidato__nombre',
                
            ))
            if len(etapaInicial)>0:
                datos= {'message': "Success","mis_postulaciones":etapaInicial}
            else:
                datos= {'message': "No se encontraron postulaciones"}
            return JsonResponse(datos)
    def listar_etapas_por_publicacion_y_usuario(request, idPublicacion, idUsuario):
        etapaInicial =  list(EtapaInicial.objects.select_related('usuario', 'publicacion')
            .filter(usuario_id=idUsuario, publicacion_id=idPublicacion)
            .values(
                    # Campos del modelo EtapaInicial
                'id', 'estado', 'observaciones',
                
            ))
        etapaMedia =  list(EtapaMedia.objects.select_related('usuario', 'publicacion')
            .filter(usuario_id=idUsuario, publicacion_id=idPublicacion)
            .values(
                    # Campos del modelo EtapaInicial
                'id', 'estado', 'observaciones', 'archivo'
            ))
        etapaFinal =  list(EtapaFinal.objects.select_related('usuario', 'publicacion')
            .filter(usuario_id=idUsuario, publicacion_id=idPublicacion)
            .values(
                    # Campos del modelo EtapaInicial
                'id', 'estado', 'observaciones', 'archivo', 'retroalimentacion'
            ))
        if len(etapaInicial)>0:
            datos= {'message': "Success","etapa_inicial":etapaInicial,"etapa_media":etapaMedia,"etapa_final":etapaFinal}
        else:
            datos= {'message': "No se encontraron postulaciones"}
        return JsonResponse(datos)
    