object Resources: TResources
  OnCreate = DataModuleCreate
  Height = 250
  Width = 376
  object LLMImages: TSVGIconImageCollection
    SVGIconItems = <
      item
        IconName = 'UserQuestion'
        SVGText = 
          '<svg viewBox="0 0 24 24">'#13#10'  <path d="M20.5,14.5V16H19V14.5H20.5' +
          'M18.5,9.5H17V9A3,3 0 0,1 20,6A3,3 0 0,1 23,9C23,9.97 22.5,10.88 ' +
          '21.71,11.41L21.41,11.6C20.84,12 20.5,12.61 20.5,13.3V13.5H19V13.' +
          '3C19,12.11 19.6,11 20.59,10.35L20.88,10.16C21.27,9.9 21.5,9.47 2' +
          '1.5,9A1.5,1.5 0 0,0 20,7.5A1.5,1.5 0 0,0 18.5,9V9.5M9,13C11.67,1' +
          '3 17,14.34 17,17V20H1V17C1,14.34 6.33,13 9,13M9,4A4,4 0 0,1 13,8' +
          'A4,4 0 0,1 9,12A4,4 0 0,1 5,8A4,4 0 0,1 9,4M9,14.9C6.03,14.9 2.9' +
          ',16.36 2.9,17V18.1H15.1V17C15.1,16.36 11.97,14.9 9,14.9M9,5.9A2.' +
          '1,2.1 0 0,0 6.9,8A2.1,2.1 0 0,0 9,10.1A2.1,2.1 0 0,0 11.1,8A2.1,' +
          '2.1 0 0,0 9,5.9Z"/>'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Assistant'
        SVGText = 
          '<svg viewBox="0 -960 960 960">'#13#10'    <circle r="70" cx="360" cy="' +
          '-640" fill="#E24444" /> '#13#10'    <circle r="70" cx="600" cy="-640" ' +
          'fill="#E24444" /> '#13#10#13#10'    <path'#13#10'        d="M160-120v-200q0-33 2' +
          '3.5-56.5T240-400h480q33 0 56.5 23.5T800-320v200H160Zm200-320'#13#10'  ' +
          '      q-83 0-141.5-58.5T160-640q0-83 58.5-141.5T360-840h240q83 0' +
          ' 141.5 58.5T800-640'#13#10'        q0 83-58.5 141.5T600-440H360Z'#13#10'    ' +
          '    M240-200h480v-120H240v120Zm120-320h240q50 0 85-35t35-85q0-50' +
          '-35-85t-85-35H360'#13#10'        q-50 0-85 35t-35 85q0 50 35 85t85 35Z' +
          '" />'#13#10'</svg>'
      end
      item
        IconName = 'ChatPlus'
        SVGText = 
          '<svg viewBox="0 0 24 24">'#13#10'  <path d="M12 3C17.5 3 22 6.58 22 11' +
          'C22 11.58 21.92 12.14 21.78 12.68C21.19 12.38 20.55 12.16 19.88 ' +
          '12.06C19.96 11.72 20 11.36 20 11C20 7.69 16.42 5 12 5C7.58 5 4 7' +
          '.69 4 11C4 14.31 7.58 17 12 17L13.09 16.95L13 18L13.08 18.95L12 ' +
          '19C10.81 19 9.62 18.83 8.47 18.5C6.64 20 4.37 20.89 2 21C4.33 18' +
          '.67 4.75 17.1 4.75 16.5C3.06 15.17 2.05 13.15 2 11C2 6.58 6.5 3 ' +
          '12 3M18 14H20V17H23V19H20V22H18V19H15V17H18V14Z"/>'#13#10'</svg>'#13#10
      end
      item
        IconName = 'ChatRemove'
        SVGText = 
          '<svg viewBox="0 0 24 24">'#13#10'  <path d="M15.46 15.88L16.88 14.46L1' +
          '9 16.59L21.12 14.47L22.54 15.88L20.41 18L22.54 20.12L21.12 21.54' +
          'L19 19.41L16.88 21.54L15.46 20.12L17.59 18L15.47 15.88M12 3C17.5' +
          ' 3 22 6.58 22 11C22 11.58 21.92 12.14 21.78 12.68C21.19 12.38 20' +
          '.55 12.16 19.88 12.06C19.96 11.72 20 11.36 20 11C20 7.69 16.42 5' +
          ' 12 5C7.58 5 4 7.69 4 11C4 14.31 7.58 17 12 17L13.09 16.95L13 18' +
          'L13.08 18.95L12 19C10.81 19 9.62 18.83 8.47 18.5C6.64 20 4.37 20' +
          '.89 2 21C4.33 18.67 4.75 17.1 4.75 16.5C3.06 15.17 2.05 13.15 2 ' +
          '11C2 6.58 6.5 3 12 3Z"/>'#13#10'</svg>'#13#10
      end
      item
        IconName = 'ChatQuestion'
        SVGText = 
          '<svg viewBox="0 0 24 24">'#13#10'  <path d="M12 3C6.5 3 2 6.6 2 11C2 1' +
          '3.2 3.1 15.2 4.8 16.5C4.8 17.1 4.4 18.7 2 21C4.4 20.9 6.6 20 8.5' +
          ' 18.5C9.6 18.8 10.8 19 12 19C17.5 19 22 15.4 22 11S17.5 3 12 3M1' +
          '2 17C7.6 17 4 14.3 4 11S7.6 5 12 5 20 7.7 20 11 16.4 17 12 17M12' +
          '.2 6.5C11.3 6.5 10.6 6.7 10.1 7C9.5 7.4 9.2 8 9.3 8.7H11.3C11.3 ' +
          '8.4 11.4 8.2 11.6 8.1C11.8 8 12 7.9 12.3 7.9C12.6 7.9 12.9 8 13.' +
          '1 8.2C13.3 8.4 13.4 8.6 13.4 8.9C13.4 9.2 13.3 9.4 13.2 9.6C13 9' +
          '.8 12.8 10 12.6 10.1C12.1 10.4 11.7 10.7 11.5 10.9C11.1 11.2 11 ' +
          '11.5 11 12H13C13 11.7 13.1 11.5 13.1 11.3C13.2 11.1 13.4 11 13.6' +
          ' 10.8C14.1 10.6 14.4 10.3 14.7 9.9C15 9.5 15.1 9.1 15.1 8.7C15.1' +
          ' 8 14.8 7.4 14.3 7C13.9 6.7 13.1 6.5 12.2 6.5M11 13V15H13V13H11Z' +
          '"/>'#13#10'</svg>'#13#10
      end
      item
        IconName = 'ChatNext'
        SVGText = 
          '<svg viewBox="0 0 24 24">'#13#10'      <path d="M12,3C6.5,3 2,6.58 2,1' +
          '1C2.05,13.15 3.06,15.17 4.75,16.5C4.75,17.1 4.33,18.67 2,21C4.37' +
          ',20.89 6.64,20 8.47,18.5C9.61,18.83 10.81,19 12,19C17.5,19 22,15' +
          '.42 22,11C22,6.58 17.5,3 12,3M12,17C7.58,17 4,14.31 4,11C4,7.69 ' +
          '7.58,5 12,5C16.42,5 20,7.69 20,11C20,14.31 16.42,17 12,17Z"/>'#13#10' ' +
          '     <path d="M12 10V7l4 4-4 4v-3H8v-2h4z" transform="translate(' +
          '0.5)"/>'#13#10'</svg>'#13#10
      end
      item
        IconName = 'ChatPrev'
        SVGText = 
          '<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">'#13#10'  ' +
          '    <path d="M12,3C6.5,3 2,6.58 2,11C2.05,13.15 3.06,15.17 4.75,' +
          '16.5C4.75,17.1 4.33,18.67 2,21C4.37,20.89 6.64,20 8.47,18.5C9.61' +
          ',18.83 10.81,19 12,19C17.5,19 22,15.42 22,11C22,6.58 17.5,3 12,3' +
          'M12,17C7.58,17 4,14.31 4,11C4,7.69 7.58,5 12,5C16.42,5 20,7.69 2' +
          '0,11C20,14.31 16.42,17 12,17Z"/>'#13#10'      <path d="M12 10V7l4 4-4 ' +
          '4v-3H8v-2h4z" transform="translate(0, -2) rotate(180, 12, 12)"/>' +
          #13#10'</svg>'
      end
      item
        IconName = 'Save'
        SVGText = 
          '<svg viewBox="0 0 24 24">'#13#10'  <path d="M17 3H5C3.89 3 3 3.9 3 5V1' +
          '9C3 20.1 3.89 21 5 21H19C20.1 21 21 20.1 21 19V7L17 3M19 19H5V5H' +
          '16.17L19 7.83V19M12 12C10.34 12 9 13.34 9 15S10.34 18 12 18 15 1' +
          '6.66 15 15 13.66 12 12 12M6 6H15V10H6V6Z"/>'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Settings'
        SVGText = 
          '<svg viewBox="0 0 24 24">'#13#10'  <path d="M12,15.5A3.5,3.5 0 0,1 8.5' +
          ',12A3.5,3.5 0 0,1 12,8.5A3.5,3.5 0 0,1 15.5,12A3.5,3.5 0 0,1 12,' +
          '15.5M19.43,12.97C19.47,12.65 19.5,12.33 19.5,12C19.5,11.67 19.47' +
          ',11.34 19.43,11L21.54,9.37C21.73,9.22 21.78,8.95 21.66,8.73L19.6' +
          '6,5.27C19.54,5.05 19.27,4.96 19.05,5.05L16.56,6.05C16.04,5.66 15' +
          '.5,5.32 14.87,5.07L14.5,2.42C14.46,2.18 14.25,2 14,2H10C9.75,2 9' +
          '.54,2.18 9.5,2.42L9.13,5.07C8.5,5.32 7.96,5.66 7.44,6.05L4.95,5.' +
          '05C4.73,4.96 4.46,5.05 4.34,5.27L2.34,8.73C2.21,8.95 2.27,9.22 2' +
          '.46,9.37L4.57,11C4.53,11.34 4.5,11.67 4.5,12C4.5,12.33 4.53,12.6' +
          '5 4.57,12.97L2.46,14.63C2.27,14.78 2.21,15.05 2.34,15.27L4.34,18' +
          '.73C4.46,18.95 4.73,19.03 4.95,18.95L7.44,17.94C7.96,18.34 8.5,1' +
          '8.68 9.13,18.93L9.5,21.58C9.54,21.82 9.75,22 10,22H14C14.25,22 1' +
          '4.46,21.82 14.5,21.58L14.87,18.93C15.5,18.67 16.04,18.34 16.56,1' +
          '7.94L19.05,18.95C19.27,19.03 19.54,18.95 19.66,18.73L21.66,15.27' +
          'C21.78,15.05 21.73,14.78 21.54,14.63L19.43,12.97Z"/>'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Copy'
        SVGText = 
          '<svg viewBox="0 0 24 24">'#13#10'  <path d="M19,21H8V7H19M19,5H8A2,2 0' +
          ' 0,0 6,7V21A2,2 0 0,0 8,23H19A2,2 0 0,0 21,21V7A2,2 0 0,0 19,5M1' +
          '6,1H4A2,2 0 0,0 2,3V17H4V3H16V1Z"/>'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Title'
        SVGText = 
          '<svg viewBox="0 0 24 24">'#13#10'   <path d="M5,4V7H10.5V19H13.5V7H19V' +
          '4H5Z" />'#13#10'</svg>'
      end
      item
        IconName = 'Cancel'
        SVGText = 
          '<svg height="24px" viewBox="0 -960 960 960" width="24px" >'#13#10'    ' +
          '<path fill="#E24444"'#13#10'        d="m336-280 144-144 144 144 56-56-' +
          '144-144 144-144-56-56-144 144-144-144-56 56 144 144-144 144 56 5' +
          '6ZM480-80q-83 0-156-31.5T197-197q-54-54-85.5-127T80-480q0-83 31.' +
          '5-156T197-763q54-54 127-85.5T480-880q83 0 156 31.5T763-763q54 54' +
          ' 85.5 127T880-480q0 83-31.5 156T763-197q-54 54-127 85.5T480-80Zm' +
          '0-80q134 0 227-93t93-227q0-134-93-227t-227-93q-134 0-227 93t-93 ' +
          '227q0 134 93 227t227 93Zm0-320Z" />'#13#10'</svg>'
      end
      item
        IconName = 'Styles'
        SVGText = 
          '<svg viewBox="0 0 32 32">'#13#10#9'<path d="M28.3,3.8H3.7C2,3.8,0.6,5.1' +
          ',0.6,6.9v18.3c0,1.7,1.4,3.1,3.1,3.1h24.6c1.7,0,3.1-1.4,3.1-3.1V6' +
          '.8C31.4,5,30,3.8,28.3,3.8z'#13#10#9#9#9'M28.3,25.1H3.7V6.8h24.6V25.1z"/>'#13 +
          #10#9'<rect fill="#4488FF" x="6.7" y="17.5" width="4.3" height="4.4"' +
          '/>'#13#10#9'<rect x="6.7" y="10.2" width="4.3" height="4.4"/>'#13#10#9'<rect x' +
          '="13.8" y="17.5" width="4.3" height="4.4"/>'#13#10#9'<rect fill="#FFCE0' +
          '0" x="13.8" y="10.2" width="4.3" height="4.4"/>'#13#10#9'<rect fill="#E' +
          '24444" x="21" y="17.5" width="4.3" height="4.4"/>'#13#10#9'<rect x="21"' +
          ' y="10.2" width="4.3" height="4.4"/>'#13#10'</svg>'#13#10
      end>
    ApplyFixedColorToRootOnly = True
    Left = 15
    Top = 15
  end
  object SynMultiSyn: TSynMultiSyn
    Schemes = <
      item
        StartExpr = '```python'
        EndExpr = '```'
        Highlighter = SynPythonSyn
        MarkerAttri.Background = clNone
        SchemeName = 'Python'
      end
      item
        StartExpr = '```delphi'
        EndExpr = '```'
        Highlighter = SynPasSyn
        MarkerAttri.Background = clNone
        SchemeName = 'Delphi'
      end
      item
        StartExpr = '```pascal'
        EndExpr = '```'
        Highlighter = SynPasSyn
        MarkerAttri.Background = clNone
        SchemeName = 'Pascal'
      end
      item
        StartExpr = '```'
        EndExpr = '```'
        Highlighter = SynPasSyn
        MarkerAttri.Background = clNone
        SchemeName = 'Pascal'
      end>
    Left = 23
    Top = 111
  end
  object SynPythonSyn: TSynPythonSyn
    Left = 103
    Top = 111
  end
  object SynPasSyn: TSynPasSyn
    Left = 191
    Top = 111
  end
end
