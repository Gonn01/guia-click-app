import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guia_click/pages/auth/register/bloc/register_bloc.dart';
import 'package:guia_click/pages/auth/register/bloc/register_event.dart';
import 'package:guia_click/pages/auth/register/bloc/register_state.dart';
import 'package:guia_click/src/auto_route/auto_route.gr.dart';

@RoutePage()
class PageRegister extends StatelessWidget {
  const PageRegister({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocProvider(
          create: (_) => RegisterBloc(),
          child: const _RegisterForm(),
        ),
      ),
    );
  }
}

class _RegisterForm extends StatelessWidget {
  const _RegisterForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state.status == FormStatus.success) {
          context.router.replace(const RouteLogin());
          print('Registration successful');
        }
        if (state.status == FormStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage ?? 'Error')),
          );
        }
      },
      child: Column(
        children: [
          BlocBuilder<RegisterBloc, RegisterState>(
            buildWhen: (p, c) => p.name != c.name,
            builder: (context, state) {
              return TextField(
                onChanged: (v) =>
                    context.read<RegisterBloc>().add(RegisterNameChanged(v)),
                decoration: const InputDecoration(labelText: 'Name'),
              );
            },
          ),
          const SizedBox(height: 16),
          BlocBuilder<RegisterBloc, RegisterState>(
            buildWhen: (p, c) => p.email != c.email,
            builder: (context, state) {
              return TextField(
                onChanged: (v) =>
                    context.read<RegisterBloc>().add(RegisterEmailChanged(v)),
                decoration: const InputDecoration(labelText: 'Email'),
              );
            },
          ),
          const SizedBox(height: 16),
          BlocBuilder<RegisterBloc, RegisterState>(
            buildWhen: (p, c) => p.password != c.password,
            builder: (context, state) {
              return TextField(
                onChanged: (v) => context
                    .read<RegisterBloc>()
                    .add(RegisterPasswordChanged(v)),
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
              );
            },
          ),
          const SizedBox(height: 24),
          BlocBuilder<RegisterBloc, RegisterState>(
            buildWhen: (p, c) => p.status != c.status,
            builder: (context, state) {
              return state.status == FormStatus.submitting
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () =>
                          context.read<RegisterBloc>().add(RegisterSubmitted()),
                      child: const Text('Register'),
                    );
            },
          ),
        ],
      ),
    );
  }
}
