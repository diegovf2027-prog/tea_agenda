alter table public.usuarios
  add column if not exists usu_trocar_senha boolean not null default false;

alter table public.usuarios
  alter column usu_trocar_senha set default true;

create or replace function public.concluir_troca_senha_primeiro_acesso()
returns void
language plpgsql
security definer
set search_path = ''
as $$
begin
  update public.usuarios
  set usu_trocar_senha = false
  where usu_id = auth.uid();

  if not found then
    raise exception 'Perfil do usuário não encontrado';
  end if;
end;
$$;

revoke all on function public.concluir_troca_senha_primeiro_acesso() from public;
grant execute on function public.concluir_troca_senha_primeiro_acesso() to authenticated;
