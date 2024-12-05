'''
from django.http.response import JsonResponse
from django.views import View
from .models import Publicaciones
from django.utils.decorators import method_decorator
from django.views.decorators.csrf import csrf_exempt

import json
# Create your views here.
from django.shortcuts import render
from django.http import JsonResponse
from .models import Publicaciones

from django.shortcuts import render
from django.http import JsonResponse

def listar_publicaciones(request, id):
    # Obtén las publicaciones relacionadas con el usuario usando el 'id' de kwargs
    publicaciones = Publicaciones.objects.filter(reclutador_id=id)
    
    if publicaciones.exists():
        # Si hay publicaciones, las devolvemos como una lista de diccionarios
        publicaciones_data = list(publicaciones.values('id','titulo', 'descripcion', 'salario', 'estado'))
        return JsonResponse({'publicaciones': publicaciones_data})
    else:
        return JsonResponse({'message': 'No hay publicaciones para este usuario'}, status=404)
'''