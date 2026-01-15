import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:guia_click/pages/auth/login/bloc/login_bloc.dart';
import 'package:guia_click/pages/auth/login/bloc/login_event.dart';
import 'package:guia_click/pages/auth/login/bloc/login_state.dart';
import 'package:guia_click/src/auto_route/auto_route.gr.dart';

@RoutePage()
class PageLogin extends StatelessWidget {
  const PageLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const primaryTeal = Color(0xFF0F7C7D);
    const lightTeal = Color(0xFF67C7C6);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocProvider(
          create: (_) => LoginBloc(),
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: const _LoginForm(
                  primaryTeal: primaryTeal,
                  lightTeal: lightTeal,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({
    required this.primaryTeal,
    required this.lightTeal,
  });
  final Color primaryTeal;
  final Color lightTeal;

  InputDecoration _decoration({
    required String hint,
    IconData? icon,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Color(0xFF9AA3AF)),
      prefixIcon:
          icon == null ? null : Icon(icon, color: const Color(0xFF9AA3AF)),
      filled: true,
      fillColor: const Color(0xFFF4F6F8),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide:
            BorderSide(color: primaryTeal.withOpacity(0.45), width: 1.2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status == FormStatus.success) {
          context.router.replace(const RouteHome());
        }
        if (state.status == FormStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage ?? 'Error')),
          );
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 8),

          // Logo (si tenés asset, reemplazalo por Image.asset)
          Center(
            child: Container(
              width: 86,
              height: 86,
              decoration: BoxDecoration(
                color: primaryTeal.withOpacity(0.10),
                borderRadius: BorderRadius.circular(20),
              ),
              child:
                  Icon(Icons.menu_book_rounded, size: 44, color: primaryTeal),
            ),
          ),

          const SizedBox(height: 14),

          const Center(
            child: Text(
              'Bienvenido a GuíaClick',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Color(0xFF111827),
              ),
            ),
          ),

          const SizedBox(height: 6),

          const Center(
            child: Text(
              'La forma más simple de aprender tecnología.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: Color(0xFF6B7280),
              ),
            ),
          ),

          const SizedBox(height: 28),

          // Email
          BlocBuilder<LoginBloc, LoginState>(
            buildWhen: (prev, curr) => prev.email != curr.email,
            builder: (context, state) {
              return TextField(
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                onChanged: (v) =>
                    context.read<LoginBloc>().add(LoginEmailChanged(v)),
                decoration: _decoration(
                  hint: 'Correo electrónico',
                  icon: Icons.alternate_email,
                ),
              );
            },
          ),

          const SizedBox(height: 12),

          // Password
          BlocBuilder<LoginBloc, LoginState>(
            buildWhen: (prev, curr) => prev.password != curr.password,
            builder: (context, state) {
              return TextField(
                obscureText: true,
                textInputAction: TextInputAction.done,
                onChanged: (v) =>
                    context.read<LoginBloc>().add(LoginPasswordChanged(v)),
                decoration:
                    _decoration(hint: 'Contraseña', icon: Icons.lock_outline),
              );
            },
          ),

          const SizedBox(height: 16),

          // Entrar
          BlocBuilder<LoginBloc, LoginState>(
            buildWhen: (prev, curr) => prev.status != curr.status,
            builder: (context, state) {
              final isLoading = state.status == FormStatus.submitting;

              return SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () => context.read<LoginBloc>().add(LoginSubmitted()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryTeal,
                    disabledBackgroundColor: primaryTeal.withOpacity(0.55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: isLoading
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          'Entrar',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                ),
              );
            },
          ),

          const SizedBox(height: 14),

          // ¿No tenés cuenta? Registrate
          Center(
            child: Text.rich(
              TextSpan(
                text: '¿No tenés cuenta? ',
                style: const TextStyle(color: Color(0xFF6B7280), fontSize: 13),
                children: [
                  TextSpan(
                    text: 'Registrate',
                    style: TextStyle(
                      color: primaryTeal,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        context.router.push(const RouteRegister());
                      },
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 18),

          // Ir al Inicio (botón secundario)
          SizedBox(
            height: 48,
            child: ElevatedButton(
              onPressed: () async {
                // Si “Inicio” es otra pantalla, reemplazá la ruta.
                await context.router.replace(const RouteHome());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: lightTeal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Ir al Inicio',
                style:
                    TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
              ),
            ),
          ),

          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
