# Home Presenter

> ## Regras

1. ✅ Chamar LoadProducts no método loadProducts
2. ✅ Notificar o isLoadingStream como true antes de chamar o LoadProducts
3. ✅ Notificar o isLoadingStream como false no fim do LoadProducts
4. ✅ Notificar o productStream com erro caso o LoadProducts retorne erro
5. ✅ Notificar o productStream com uma lista de Produtos caso o LoadProducts retorne sucesso
6. ✅ Notificar o isLoadingStream como true antes de chamar o DeleteProduct
7. ✅ Notificar o isLoadingStream como false no fim do DeleteProduct
8. ✅ Notificar o deleteProductErrorStream com erro caso o DeleteProduct retorne erro
9. ✅ Notificar o deleteProductErrorStream com um UIError.none caso o DeleteProduct retorne void
10. Levar o usuário pra tela de Edição de Produto ao clicar em algum produto
