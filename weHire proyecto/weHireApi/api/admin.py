from django.contrib import admin
from .models import Rol, Usuarios , Publicaciones, EtapaInicial,EtapaMedia,EtapaFinal
# Register your models here.
admin.site.register(Rol)
admin.site.register(Usuarios)
admin.site.register(Publicaciones)
admin.site.register(EtapaInicial)
admin.site.register(EtapaMedia)
admin.site.register(EtapaFinal)
