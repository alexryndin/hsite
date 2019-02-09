--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
import           Data.Monoid ((<>))
import           Hakyll


--------------------------------------------------------------------------------
main :: IO ()
main = hakyll $ do
    match "images/*" $ do
        route   idRoute
        compile copyFileCompiler

    match "css/*" $ do
        route   idRoute
        compile compressCssCompiler

    create ["index.html", "404.html"] $ do
      route idRoute
      compile $
        getResourceBody
          >>= loadAndApplyTemplate "templates/default.html" defaultContext

    match "about.md" $ do
        route $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/about.html" postCtx

    -- create ["404.html", "index.html"] $ do
    --   route idRoute
    --   compile $ do
    --     load "templates/404.html" :: Compiler (Item String)

        -- getResourceBody
        --   >>= loadAndApplyTemplate "templates/default.html" defaultContext
        --   >>= loadAndApplyTemplate "templates/404.html" defaultContext
        --   >>= relativizeUrls


    -- match "posts/*" $ do
    --     route $ setExtension "html"
    --     compile $ pandocCompiler
    --         >>= loadAndApplyTemplate "templates/post.html"    postCtx
    --         >>= loadAndApplyTemplate "templates/default.html" postCtx
    --         >>= relativizeUrls


    -- create ["archive.html"] $ do
    --   route idRoute
    --   compile $ do
    --     posts <- recentFirst =<< loadAll "posts/*"
    --     let archiveCtx =
    --           listField "posts" postCtx (return posts) <>
    --           constField "title" "Archives"            <>
    --           defaultContext
    --     makeItem ""
    --             >>= loadAndApplyTemplate "templates/archive.html" archiveCtx
    --             >>= loadAndApplyTemplate "templates/default.html" archiveCtx
    --             >>= relativizeUrls




    match "templates/*" $ compile templateBodyCompiler


--------------------------------------------------------------------------------
postCtx :: Context String
postCtx =
    dateField "date" "%B %e, %Y" `mappend`
    defaultContext
