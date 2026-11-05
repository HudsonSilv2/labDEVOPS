async function testar() {
  const backend = document.querySelector('#backend');
  const banco = document.querySelector('#banco');
  backend.textContent = 'verificando...';
  banco.textContent = 'verificando...';

  try {
    const resposta = await fetch('/api/status');
    const dados = await resposta.json();
    backend.textContent = dados.backend;
    banco.textContent = dados.banco;
  } catch {
    backend.textContent = 'indisponível';
    banco.textContent = 'não verificado';
  }
}

document.querySelector('#testar').addEventListener('click', testar);
testar();
