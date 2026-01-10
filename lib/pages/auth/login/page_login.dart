import 'package:auto_route/auto_route.dart';
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
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocProvider(
          create: (_) => LoginBloc(),
          child: const _LoginForm(),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status == FormStatus.success) {
          context.router.replace(const RouteHome());
          print('Login successful! Navigating to home page.');
        }
        if (state.status == FormStatus.failure) {
          print('Login successful! Navigating to home pag2222.');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage ?? 'Error')),
          );
        }
      },
      child: Column(
        children: [
          BlocBuilder<LoginBloc, LoginState>(
            buildWhen: (prev, curr) => prev.email != curr.email,
            builder: (context, state) {
              return TextField(
                onChanged: (v) =>
                    context.read<LoginBloc>().add(LoginEmailChanged(v)),
                decoration: const InputDecoration(labelText: 'Email'),
              );
            },
          ),
          const SizedBox(height: 16),
          BlocBuilder<LoginBloc, LoginState>(
            buildWhen: (prev, curr) => prev.password != curr.password,
            builder: (context, state) {
              return TextField(
                onChanged: (v) =>
                    context.read<LoginBloc>().add(LoginPasswordChanged(v)),
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
              );
            },
          ),
          const SizedBox(height: 24),
          BlocBuilder<LoginBloc, LoginState>(
            buildWhen: (prev, curr) => prev.status != curr.status,
            builder: (context, state) {
              return state.status == FormStatus.submitting
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () =>
                          context.read<LoginBloc>().add(LoginSubmitted()),
                      child: const Text('Login'),
                    );
            },
          ),
        ],
      ),
    );
  }
}
