import json
import os
from urllib import request
from uuid import uuid4
from django.http.response import JsonResponse
from django.views import View
from ..models import Usuarios,Rol
from django.utils.decorators import method_decorator
from django.views.decorators.csrf import csrf_exempt
from ..vistas.correos import enviar_correo

# Create your views here.
class UsuariosView(View):
    @method_decorator(csrf_exempt)
    def dispatch(self, request, *args, **kwargs):
        return super().dispatch(request, *args, **kwargs)
    
    def get(self,request, id=0):
        if(id>0):
            usuarios= list(Usuarios.objects.filter(id=id).values())
            if len(usuarios)>0:
                usuario = usuarios[0]
                datos= {'message': "Success",'usuarios': usuario}
            else:  
                datos={'message': "Usuario no encontrado"}
            return JsonResponse(datos)
           
        else:
            usuarios = list(Usuarios.objects.values())
            if len(usuarios)>0:
                datos= {'message': "Success","usuarios":usuarios}
                #enviar_correo_etapa_inicial()
            else:
                datos= {'message': "Usuarios no encontrados"}
            return JsonResponse(datos)
    
    def post(self, request, action):
        try:
            if action == "REGISTRAR":
                nombreArchivo = None
                if 'hoja_vida' in request.FILES:
                    nombreArchivo = self.guardar_archivo(request.FILES.get('hoja_vida'))
                Usuarios.objects.create(
                    nombre = request.POST.get('nombre'),
                    apellido = request.POST.get('apellido'),
                    correo = request.POST.get('correo'),
                    clave = request.POST.get('clave'),
                    fecha_nacimiento = request.POST.get('fecha_nacimiento') or None,
                    telefono = request.POST.get('telefono'),
                    celular = request.POST.get('celular'),
                   # hoja_vida = request.FILES['hoja_vida'],
                    hoja_vida=nombreArchivo,
                    rol_id = request.POST.get('rol_id'),
                )
            
                return JsonResponse({'message': 'Usuario registrado correctamente'}, status=201)
            elif action == "ACTUALIZAR":
                
                nombreArchivo = None
                if 'hoja_vida' in request.FILES:
                    nombreArchivo = self.guardar_archivo(request.FILES.get('hoja_vida'))
                usuarios= list(Usuarios.objects.filter(id=request.POST.get('id')).values())
                if len(usuarios)>0:
                    usuario =Usuarios.objects.get(id=request.POST.get('id'))
                    usuario.nombre=request.POST.get('nombre') if request.POST.get('nombre') != None else usuario.nombre
                    usuario.apellido=request.POST.get('apellido') if request.POST.get('apellido') != None else usuario.apellido
                    usuario.correo=request.POST.get('correo') if request.POST.get('correo') != None else usuario.correo
                    usuario.clave=request.POST.get('clave') if request.POST.get('clave') != None else usuario.clave
                    usuario.fecha_nacimiento=request.POST.get('fecha_nacimiento') if request.POST.get('fecha_nacimiento') != None else usuario.fecha_nacimiento
                    usuario.telefono=request.POST.get('telefono') if request.POST.get('telefono') != None else usuario.telefono
                    usuario.celular=request.POST.get('celular') if request.POST.get('celular') != None else usuario.celular
                    usuario.hoja_vida=nombreArchivo

                   
                    usuario.save()
                    datos= {'message': "Usuario actualizado correctamente", 'datosNuevos': request.POST.get("nombre") }
                else:
                    datos= {'message': "No se encuentra el usuario indicado"}
                return JsonResponse(datos,status=201)
            elif action == "INICIAR_SESION":
                correo = request.POST.get('correo')
                clave = request.POST.get('clave')
                
                usuario = Usuarios.objects.select_related('rol').filter(correo=correo).first()
                
                if usuario:
                    if clave==usuario.clave:
                        print(usuario)
                        usuarioObjeto = {
                            'id': usuario.id,
                            'nombre': usuario.nombre,
                            'apellido': usuario.apellido,
                            'correo': usuario.correo,
                            'fecha_nacimiento': usuario.fecha_nacimiento,
                            'telefono': usuario.telefono,
                            'celular': usuario.celular,
                            'hoja_vida': usuario.hoja_vida.url if usuario.hoja_vida else None,
                            'rol': {
                                'id': usuario.rol.id if usuario.rol else None,
                                'nombre': usuario.rol.nombre if usuario.rol else None,
                            },
                        }
                        datos = {'message': "Success", 'usuario': usuarioObjeto}
                    else:
                        datos = {'message': "Usuario o contraseña incorrecta."}
                else:
                    datos = {'message': "Usuario o contraseña incorrecta."}
            return JsonResponse(datos)
            
        except Exception as e:
            return JsonResponse({'message': f'Error al iniciar sesion: {str(e)}'}, status=500)
    @staticmethod
    def guardar_archivo(archivo):
        ruta_absoluta = r"C:/Users/User/Desktop/WeHireAngular/weHire/src/assets/hojas_de_vida/"
        
        if not os.path.exists(ruta_absoluta):
            os.makedirs(ruta_absoluta)
        
        extension = os.path.splitext(archivo.name)[1] 
        nuevo_nombre = f"{uuid4()}{extension}" 
        
        ruta_archivo = os.path.join(ruta_absoluta, nuevo_nombre)

        with open(ruta_archivo, 'wb+') as destino:
            for chunk in archivo.chunks():
                destino.write(chunk)
        return nuevo_nombre