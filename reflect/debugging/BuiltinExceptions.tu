import "Exception.tu"

module BuiltinExceptions
    import Exception
    
    class GeneralException
        inherit Exception
    end GeneralException
    
    class FileSystemException
        inherit Exception
    end FileSystemException
    
    class StreamException
        inherit Exception
    end StreamException
    
    class FileException
        inherit Exception
    end FileException
    
    class DirectoryException
        inherit Exception
    end DirectoryException
    
    class PictureException
        inherit Exception
    end PictureException
    
    class PenException
        inherit Exception
    end PenException
    
    class BrushException
        inherit Exception
    end BrushException
    
    class SpriteException
        inherit Exception
    end SpriteException
    
    class FontException
        inherit Exception
    end FontException
    
    class DrawingException
        inherit Exception
    end DrawingException
    
    class TimeException
        inherit Exception
    end TimeException
    
    class MouseException
        inherit Exception
    end MouseException
    
    class ColorException
        inherit Exception
    end ColorException
    
    class MusicException
        inherit Exception
    end MusicException
    
    class ConfigurationException
        inherit Exception
    end ConfigurationException
    
    class ViewException
        inherit Exception
    end ViewException
    
    class WindowException
        inherit Exception
    end WindowException
    
    class PrinterException
        inherit Exception
    end PrinterException
    
    class TextException
        inherit Exception
    end TextException
    
    class GUIException
        inherit Exception
    end GUIException
    
    class LexicalException
        inherit Exception
    end LexicalException
    
    class NetworkException
        inherit Exception
    end NetworkException
    
    class PCException
        inherit Exception
    end PCException
    
    class SystemException
        inherit Exception
    end SystemException
    
    class INIFileException
        inherit Exception
    end INIFileException
    
    class StringException
        inherit Exception
    end StringException
    
end BuiltinExceptions