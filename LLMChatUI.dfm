object LLMChatForm: TLLMChatForm
  Left = 0
  Top = 0
  Caption = 'Chat with LLM'
  ClientHeight = 655
  ClientWidth = 852
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  ShowHint = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  TextHeight = 15
  object pnlQuestion: TPanel
    Left = 0
    Top = 560
    Width = 852
    Height = 95
    Align = alBottom
    TabOrder = 0
    DesignSize = (
      852
      95)
    object sbAsk: TSpeedButton
      Left = 804
      Top = 4
      Width = 32
      Height = 32
      Action = actAskQuestion
      Anchors = [akTop, akRight]
      Images = vilImages
      Flat = True
    end
    object reQuestion: TRichEdit
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 791
      Height = 87
      Align = alLeft
      Anchors = [akLeft, akTop, akRight, akBottom]
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Consolas'
      Font.Style = []
      ParentFont = False
      PlainText = True
      ScrollBars = ssVertical
      SpellChecking = True
      TabOrder = 0
      OnKeyDown = reQuestionKeyDown
    end
    object aiBusy: TActivityIndicator
      Left = 804
      Top = 49
      Anchors = [akRight, akBottom]
      IndicatorType = aitSectorRing
    end
  end
  object ScrollBox: TScrollBox
    Left = 0
    Top = 34
    Width = 852
    Height = 526
    HorzScrollBar.Visible = False
    VertScrollBar.Tracking = True
    Align = alClient
    ParentBackground = True
    TabOrder = 1
    UseWheelForScrolling = True
    object QAStackPanel: TStackPanel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 842
      Height = 23
      Align = alTop
      AutoSize = True
      BevelOuter = bvNone
      ControlCollection = <>
      DoubleBuffered = True
      HorizontalPositioning = sphpFill
      ParentDoubleBuffered = False
      TabOrder = 0
    end
  end
  object SpTBXDock: TSpTBXDock
    Left = 0
    Top = 0
    Width = 852
    Height = 34
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
      object SpTBXItem3: TSpTBXItem
        Action = actChatNew
      end
      object SpTBXItem4: TSpTBXItem
        Action = actChatRemove
      end
      object SpTBXSeparatorItem2: TSpTBXSeparatorItem
      end
      object spiSave: TSpTBXItem
        Action = actChatSave
      end
      object SpTBXRightAlignSpacerItem: TSpTBXRightAlignSpacerItem
        CustomWidth = 648
      end
      object SpTBXItem2: TSpTBXItem
        Action = actChatPrevious
      end
      object SpTBXItem1: TSpTBXItem
        Action = actChatNext
      end
      object SpTBXSubmenuItem1: TSpTBXSubmenuItem
        Caption = 'Settings:'
        ImageIndex = 8
        ImageName = 'Settings'
        Options = [tboDropdownArrow]
        OnInitPopup = SpTBXSubmenuItem1InitPopup
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
          EditCaption = 'Api key: '
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
  object vilImages: TVirtualImageList
    AutoFill = True
    Images = <
      item
        CollectionIndex = 0
        CollectionName = 'UserQuestion'
        Name = 'UserQuestion'
      end
      item
        CollectionIndex = 1
        CollectionName = 'ChatGPT'
        Name = 'ChatGPT'
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
        CollectionName = 'Next'
        Name = 'Next'
      end
      item
        CollectionIndex = 6
        CollectionName = 'Previous'
        Name = 'Previous'
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
      end>
    ImageCollection = Resources.LLMImages
    Width = 24
    Height = 24
    Left = 32
    Top = 504
  end
  object ActionList: TActionList
    Images = vilImages
    OnUpdate = ActionListUpdate
    Left = 32
    Top = 440
    object actChatSave: TAction
      Caption = 'Save chat'
      Hint = 'Save chat history'
      ImageIndex = 7
      ImageName = 'Save'
      OnExecute = actChatSaveExecute
    end
    object actChatRemove: TAction
      Caption = 'Remove Chat Topic'
      Hint = 'Remove current chat topic'
      ImageIndex = 3
      ImageName = 'ChatRemove'
      OnExecute = actChatRemoveExecute
    end
    object actChatNew: TAction
      Caption = 'New Chat Topic'
      Hint = 'Add a new chat topic'
      ImageIndex = 2
      ImageName = 'ChatPlus'
      OnExecute = actChatNewExecute
    end
    object actChatPrevious: TAction
      Caption = 'Previous Chat Topic'
      Hint = 'Show previous chat topic'
      ImageIndex = 6
      ImageName = 'Previous'
      OnExecute = actChatPreviousExecute
    end
    object actChatNext: TAction
      Caption = 'Next Chat Topic'
      Hint = 'Show next chat topic'
      ImageIndex = 5
      ImageName = 'Next'
      OnExecute = actChatNextExecute
    end
    object actCopyText: TAction
      Caption = 'Copy '
      Hint = 'Copy text'
      ImageIndex = 9
      ImageName = 'Copy'
      OnExecute = actCopyTextExecute
    end
    object actAskQuestion: TAction
      Hint = 'Ask question'
      ImageIndex = 4
      ImageName = 'ChatQuestion'
      OnExecute = actAskQuestionExecute
    end
  end
  object ApplicationEvents: TApplicationEvents
    OnMessage = ApplicationEventsMessage
    Left = 32
    Top = 320
  end
  object popTextMenu: TPopupMenu
    Images = vilImages
    Left = 32
    Top = 376
    object Copy1: TMenuItem
      Action = actCopyText
    end
  end
end
