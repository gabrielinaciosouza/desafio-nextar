# Home Presenter

> ## Regras

1. ✅ Chamar LoadProducts no método loadProducts
2. ✅ Notificar o isLoadingStream como true antes de chamar o LoadProducts
3. ✅ Notificar o isLoadingStream como false no fim do LoadProducts
4. ✅ Notificar o productStream com erro caso o LoadProducts retorne erro
5. ✅ Notificar o productStream com uma lista de Produtos caso o LoadProducts retorne sucesso

6. ✅ Notificar o isLoadingStream como true antes de chamar o DeleteProduct
7. ✅ Notificar o isLoadingStream como false no fim do DeleteProduct
8. ✅ Notificar o errorStream com erro caso o DeleteProduct retorne erro
9. ✅ Notificar o errorStream com um UIError.none caso o DeleteProduct retorne void

10. ✅ Notificar o isLoadingStream como true antes de chamar o Logoff
11. ✅ Notificar o isLoadingStream como false no fim do Logoff
12. ✅ Notificar o errorStream com erro caso o Logoff retorne erro
13. ✅ Notificar o errorStream com um UIError.none caso o Logoff retorne void
14. ✅ Levar o usuário pra tela de Login em caso de sucesso

15. ✅ Levar o usuário pra tela de Edição de Produto ao clicar em algum produto
