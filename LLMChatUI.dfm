object LLMChatForm: TLLMChatForm
  Left = 0
  Top = 0
  HelpContext = 497
  Caption = 'Chat'
  ClientHeight = 655
  ClientWidth = 852
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  StyleElements = [seFont, seBorder]
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 15
  object pnlQuestion: TPanel
    Left = 0
    Top = 570
    Width = 852
    Height = 85
    Align = alBottom
    ParentBackground = False
    ParentColor = True
    TabOrder = 0
    DesignSize = (
      852
      85)
    object sbAsk: TSpeedButton
      Left = 815
      Top = 6
      Width = 32
      Height = 32
      Action = actAskQuestion
      Anchors = [akTop, akRight]
      Images = vilImages
      Flat = True
    end
    object aiBusy: TActivityIndicator
      Left = 815
      Top = 46
      Anchors = [akRight, akBottom]
      FrameDelay = 150
      IndicatorType = aitRotatingSector
    end
    object synQuestion: TSynEdit
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 805
      Height = 77
      Cursor = crDefault
      Align = alLeft
      Anchors = [akLeft, akTop, akRight, akBottom]
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Consolas'
      Font.Style = []
      Font.Quality = fqClearTypeNatural
      PopupMenu = pmAsk
      TabOrder = 0
      OnEnter = synQuestionEnter
      OnKeyDown = synQuestionKeyDown
      UseCodeFolding = False
      Gutter.Font.Charset = DEFAULT_CHARSET
      Gutter.Font.Color = clWindowText
      Gutter.Font.Height = -11
      Gutter.Font.Name = 'Consolas'
      Gutter.Font.Style = []
      Gutter.Font.Quality = fqClearTypeNatural
      Gutter.Visible = False
      Gutter.Bands = <
        item
          Kind = gbkMarks
          Width = 13
        end
        item
          Kind = gbkLineNumbers
        end
        item
          Kind = gbkFold
        end
        item
          Kind = gbkTrackChanges
        end
        item
          Kind = gbkMargin
          Width = 3
        end>
      HideSelection = True
      Highlighter = Resources.SynMultiSyn
      RightEdge = 0
      ScrollBars = ssVertical
      ScrollbarAnnotations = <
        item
          AnnType = sbaCarets
          AnnPos = sbpFullWidth
          FullRow = False
        end>
      VisibleSpecialChars = []
      WordWrap = True
    end
  end
  object Splitter: TSpTBXSplitter
    Left = 0
    Top = 565
    Width = 852
    Height = 5
    Cursor = crSizeNS
    Align = alBottom
    ParentColor = False
    MinSize = 90
  end
  object SpTBXDock: TSpTBXDock
    Left = 0
    Top = 0
    Width = 852
    Height = 34
    AllowDrag = False
    DoubleBuffered = True
    object SpTBXToolbar: TSpTBXToolbar
      Left = 0
      Top = 0
      CloseButton = False
      DockMode = dmCannotFloatOrChangeDocks
      DockPos = 0
      DragHandleStyle = dhNone
      FullSize = True
      Images = vilImages
      ParentShowHint = False
      ShowHint = True
      ShrinkMode = tbsmNone
      Stretch = True
      TabOrder = 0
      Customizable = False
      object spiNewTopic: TSpTBXItem
        Action = actChatNew
      end
      object spiRemoveTopic: TSpTBXItem
        Action = actChatRemove
      end
      object SpTBXSeparatorItem2: TSpTBXSeparatorItem
      end
      object spiPreviousTopic: TSpTBXItem
        Action = actChatPrevious
      end
      object spiNextTopic: TSpTBXItem
        Action = actChatNext
      end
      object SpTBXSeparatorItem7: TSpTBXSeparatorItem
      end
      object spiSave: TSpTBXItem
        Action = actChatSave
      end
      object SpTBXSeparatorItem4: TSpTBXSeparatorItem
      end
      object spiTitle: TSpTBXItem
        Action = actTopicTitle
      end
      object spiCancel: TTBItem
        Action = actCancelRequest
      end
      object SpTBXRightAlignSpacerItem: TSpTBXRightAlignSpacerItem
        CustomWidth = 543
      end
      object SpTBXSubmenuItem1: TSpTBXSubmenuItem
        Caption = 'Style'
        Hint = 'Select application style'
        ImageIndex = 12
        ImageName = 'Styles'
        object SpTBXSkinGroupItem1: TSpTBXSkinGroupItem
        end
      end
      object spiSettings: TSpTBXSubmenuItem
        Caption = 'Settings'
        HelpContext = 770
        ImageIndex = 8
        ImageName = 'Settings'
        Options = [tboDropdownArrow]
        OnInitPopup = spiSettingsInitPopup
        object spiDeepSeek: TSpTBXItem
          Caption = 'DeepSeek'
          Hint = 'Use DeepSeek'
          AutoCheck = True
          GroupIndex = 1
          ImageIndex = 14
          ImageName = 'deepseek'
          OnClick = mnProviderClick
          OnDrawImage = LogoDrawImage
        end
        object spiGemini: TSpTBXItem
          Caption = 'Gemini'
          Hint = 'Use Gemini'
          AutoCheck = True
          GroupIndex = 1
          ImageIndex = 15
          ImageName = 'gemini'
          OnClick = mnProviderClick
          OnDrawImage = LogoDrawImage
        end
        object spiOpenai: TSpTBXItem
          Caption = 'OpenAI'
          Hint = 'Use OpenAI'
          AutoCheck = True
          Checked = True
          GroupIndex = 1
          ImageIndex = 16
          ImageName = 'openai'
          OnClick = mnProviderClick
          OnDrawImage = LogoDrawImage
        end
        object spiOllama: TSpTBXItem
          Caption = 'Ollama'
          Hint = 'Use Ollama'
          AutoCheck = True
          GroupIndex = 1
          ImageIndex = 13
          ImageName = 'ollama'
          OnClick = mnProviderClick
          OnDrawImage = LogoDrawImage
        end
        object SpTBXSeparatorItem6: TSpTBXSeparatorItem
        end
        object spiEndpoint: TSpTBXEditItem
          CustomWidth = 100
          EditCaption = 'Endpoint:'
          ExtendedAccept = True
          OnAcceptText = AcceptSettings
        end
        object spiModel: TSpTBXEditItem
          CustomWidth = 100
          EditCaption = 'Model:'
          ExtendedAccept = True
          OnAcceptText = AcceptSettings
        end
        object spiApiKey: TSpTBXEditItem
          CustomWidth = 300
          EditCaption = 'Api key:'
          ExtendedAccept = True
          PasswordChar = #9679
          OnAcceptText = AcceptSettings
        end
        object SpTBXSeparatorItem1: TSpTBXSeparatorItem
        end
        object spiTimeout: TSpTBXEditItem
          EditCaption = 'Timeout (in seconds):'
          ExtendedAccept = True
          OnAcceptText = AcceptSettings
        end
        object spiTemperature: TSpTBXEditItem
          EditCaption = 'Temperature:'
          OnAcceptText = AcceptSettings
        end
        object spiMaxTokens: TSpTBXEditItem
          EditCaption = 'Maximum number of response tokens:'
          ExtendedAccept = True
          OnAcceptText = AcceptSettings
        end
        object spiSystemPrompt: TSpTBXEditItem
          EditCaption = 'System prompt:'
          ExtendedAccept = True
          OnAcceptText = AcceptSettings
        end
      end
    end
  end
  object EdgeBrowser: TEdgeBrowser
    Left = 0
    Top = 34
    Width = 852
    Height = 531
    Align = alClient
    TabOrder = 3
    AllowSingleSignOnUsingOSPrimaryAccount = False
    TargetCompatibleBrowserVersion = '117.0.2045.28'
    UserDataFolder = '%LOCALAPPDATA%\LLMChat\WebView2'
    OnCreateWebViewCompleted = EdgeBrowserCreateWebViewCompleted
    OnNavigationCompleted = EdgeBrowserNavigationCompleted
    OnWebMessageReceived = EdgeBrowserWebMessageReceived
  end
  object vilImages: TVirtualImageList
    Images = <
      item
        CollectionIndex = 0
        CollectionName = 'UserQuestion'
        Name = 'UserQuestion'
      end
      item
        CollectionIndex = 1
        CollectionName = 'Assistant'
        Name = 'Assistant'
      end
      item
        CollectionIndex = 2
        CollectionName = 'ChatPlus'
        Name = 'ChatPlus'
      end
      item
        CollectionIndex = 3
        CollectionName = 'ChatRemove'
        Name = 'ChatRemove'
      end
      item
        CollectionIndex = 4
        CollectionName = 'ChatQuestion'
        Name = 'ChatQuestion'
      end
      item
        CollectionIndex = 5
        CollectionName = 'ChatNext'
        Name = 'ChatNext'
      end
      item
        CollectionIndex = 6
        CollectionName = 'ChatPrev'
        Name = 'ChatPrev'
      end
      item
        CollectionIndex = 7
        CollectionName = 'Save'
        Name = 'Save'
      end
      item
        CollectionIndex = 8
        CollectionName = 'Settings'
        Name = 'Settings'
      end
      item
        CollectionIndex = 9
        CollectionName = 'Copy'
        Name = 'Copy'
      end
      item
        CollectionIndex = 10
        CollectionName = 'Title'
        Name = 'Title'
      end
      item
        CollectionIndex = 11
        CollectionName = 'Cancel'
        Name = 'Cancel'
      end
      item
        CollectionIndex = 12
        CollectionName = 'Styles'
        Name = 'Styles'
      end
      item
        CollectionIndex = 13
        CollectionName = 'ollama'
        Name = 'ollama'
      end
      item
        CollectionIndex = 14
        CollectionName = 'deepseek'
        Name = 'deepseek'
      end
      item
        CollectionIndex = 15
        CollectionName = 'gemini'
        Name = 'gemini'
      end
      item
        CollectionIndex = 16
        CollectionName = 'openai'
        Name = 'openai'
      end
      item
        CollectionIndex = 17
        CollectionName = 'Paste'
        Name = 'Paste'
      end>
    ImageCollection = Resources.LLMImages
    Width = 24
    Height = 24
    Left = 24
    Top = 456
  end
  object ChatActionList: TActionList
    Images = vilImages
    OnUpdate = ChatActionListUpdate
    Left = 32
    Top = 392
    object actChatSave: TAction
      Category = 'Chat'
      Caption = 'Save chat'
      Hint = 'Save chat history'
      ImageIndex = 7
      ImageName = 'Save'
      OnExecute = actChatSaveExecute
    end
    object actChatRemove: TAction
      Category = 'Chat'
      Caption = 'Remove Chat Topic'
      Hint = 'Remove current chat topic'
      ImageIndex = 3
      ImageName = 'ChatRemove'
      OnExecute = actChatRemoveExecute
    end
    object actChatNew: TAction
      Category = 'Chat'
      Caption = 'New Chat Topic'
      Hint = 'Add a new chat topic'
      ImageIndex = 2
      ImageName = 'ChatPlus'
      OnExecute = actChatNewExecute
    end
    object actChatPrevious: TAction
      Category = 'Chat'
      Caption = 'Previous Chat Topic'
      Hint = 'Show previous chat topic'
      ImageIndex = 6
      ImageName = 'ChatPrev'
      OnExecute = actChatPreviousExecute
    end
    object actChatNext: TAction
      Category = 'Chat'
      Caption = 'Next Chat Topic'
      Hint = 'Show next chat topic'
      ImageIndex = 5
      ImageName = 'ChatNext'
      OnExecute = actChatNextExecute
    end
    object actAskQuestion: TAction
      Category = 'Chat'
      Hint = 'Ask question'
      ImageIndex = 4
      ImageName = 'ChatQuestion'
      OnExecute = actAskQuestionExecute
    end
    object actTopicTitle: TAction
      Category = 'Chat'
      Caption = 'Topic Title'
      Hint = 'Set the title of the chat topic'
      ImageIndex = 10
      ImageName = 'Title'
      OnExecute = actTopicTitleExecute
    end
    object actCancelRequest: TAction
      Category = 'Chat'
      Caption = 'Cancel Request'
      Hint = 'Cancel active request'
      ImageIndex = 11
      ImageName = 'Cancel'
      OnExecute = actCancelRequestExecute
    end
    object actEditCopy: TEditCopy
      Category = 'Edit'
      Caption = '&Copy'
      Hint = 'Copy|Copies the selection and puts it on the Clipboard'
      ImageIndex = 9
      ImageName = 'Copy'
      ShortCut = 16451
    end
    object actEditPaste: TEditPaste
      Category = 'Edit'
      Caption = '&Paste'
      Hint = 'Paste|Inserts Clipboard contents'
      ImageIndex = 17
      ImageName = 'Paste'
      ShortCut = 16470
    end
  end
  object pmAsk: TSpTBXPopupMenu
    Images = vilImages
    Left = 24
    Top = 104
    object mnCopy: TSpTBXItem
      Action = actEditCopy
    end
    object mnPaste: TSpTBXItem
      Action = actEditPaste
    end
  end
end
