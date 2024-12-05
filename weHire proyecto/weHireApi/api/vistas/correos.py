from django.core.mail import send_mail
from ..models import Usuarios

def enviar_correo(idUsuario,etapa,estado, publicacion):
    print(idUsuario)
    usuario= Usuarios.objects.filter(id=idUsuario).first()
    if (usuario != None):
        nombreUsuario = usuario.nombre
        
        asunto = '¡Hola, '+etapa.lower()+" actualizada!"
        mensaje = f"""
            <html>
                <body style="font-family: Arial, sans-serif; line-height: 1.6; padding: 16px; width: 800px; margin: auto;">
                    <h1 style="text-align: center; border: 2px #3b5998 solid; border-radius: 10px; padding: 10px; box-shadow: 1px 1px 10px 1px #3b5998; color: #3b5998;">
                        ¡Hola, {nombreUsuario}!
                    </h1>
                    <div style="border: 2px #3b5998 solid; border-radius: 10px; padding: 20px; box-shadow: 1px 1px 10px 1px #3b5998;">
                        <p style="color: #F66D46; font-size: 20px;">Tenemos información de tu postulación a: <strong>{publicacion.titulo}</strong></p>
                        <hr>
                        
                        <!-- Etapa actualizada -->
                        <p>La <strong style="color: #F66D46;">{etapa.lower()}</strong> ha sido actualizada. Ingresa a 
                            <a href="http://localhost:4200/" style="color: #3b5998; text-decoration: none;">WeHire</a> para revisar las 
                            observaciones que te han dejado ¡Y te enteres como continua el proceso!
                        </p>
                        <!-- Etapa actualizada -->
        """
        
        if (estado == 'CONTINUA'):
            mensaje += f"""
                    <p style="color: #F66D46;">¡Super!</p>
                    <p style="color: #3b5998;">¡Continúas con la <strong>{proximaEtapa(etapa)}</strong> de la postulación!</p>
            """
        elif (estado == 'TERMINADO'):
            mensaje += """
                    <!-- Etapa Inicial o Etapa Media y estado Terminado -->
                    <p style="color: #F66D46;">Lo sentimos :( </p>
                    <p>Parece que no cumples con los requisitos solicitados en la postulación. Por favor, continúa creciendo y mantente pendiente de nuevas postulaciones para tu perfil.</p>
                    <!-- Etapa Inicial o Etapa Media y estado Terminado -->
            """
        elif (estado == 'COMPLETADO'):
            mensaje += f"""
                    <!-- Etapa Final y estado COMPLETADA -->
                    <p style="color: #F66D46;">¡Maravilloso!</p>
                    <p style="color: #3b5998;">!Has finalizado con la etapa <strong>{etapa.lower()}</strong> de la postulación!</p>
                    <p style="color: #3b5998;">Esperamos que haya sido un proceso exitoso. Te deseamos suerte en tu camino.</p>
                    <!-- Etapa Final y estado COMPLETADA -->
            """
        
        
        mensaje += """
                    <p>Gracias por confiar en <strong>WeHire</strong>.</p>
                    </div>
                    <p style="font-size: 0.9em; color: #888; margin: 10px 30px;">Este es un correo automático, por favor no respondas a este mensaje.</p>
                </body>
            </html>
        """
        remitente = 'proyectowehire@gmail.com'
        usuarioReclutador = Usuarios.objects.filter(id=publicacion.reclutador_id).first()
        destinatarios = [usuario.correo, usuarioReclutador.correo]
        send_mail(asunto, mensaje, remitente, destinatarios, html_message=mensaje)
        
def proximaEtapa(etapa):
    proximaEtapa = "Etapa Media"
    if(etapa.lower() == 'etapa inicial'): 
        proximaEtapa = "Etapa Media"
    elif(etapa.lower() == "etapa media"):
        proximaEtapa = "Etapa Final"
    return proximaEtapa

    
