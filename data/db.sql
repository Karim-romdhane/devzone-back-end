BEGIN;

DROP TABLE IF EXISTS "User", "Tool", "Bookmark", "ToolsOnUsers";
DROP DOMAIN IF EXISTS mail;


CREATE TABLE IF NOT EXISTS public."User"
(
    "id" integer GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    "email" text  NOT NULL,
    "password" text  NOT NULL,
    "firstname" text,
    "lastname" text ,
    "username" text NOT NULL,
    "avatar" text
    
);
CREATE TABLE IF NOT EXISTS public."Tool"
(
    "id" integer GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    "name" text  NOT NULL,
   "logo" text,
    "description" text
    
);


CREATE TABLE IF NOT EXISTS public."Bookmark"
(
    "id" integer GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    "name" text  NOT NULL,
    "description" text,
    "link" text,
    "linkImg" text,
    "userId" integer,
    "toolId" integer,
    
    CONSTRAINT "bookmark_toolId_fkey" FOREIGN KEY ("toolId")
        REFERENCES public."Tool" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "bookmark_userId_fkey" FOREIGN KEY ("userId")
        REFERENCES public."User" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);


CREATE TABLE IF NOT EXISTS public."ToolsOnUsers"
(
    "userId" integer NOT NULL,
    "toolId" integer NOT NULL,
    "created_at" timestamp(6) with time zone NOT NULL DEFAULT NOW(),
    "updated_at" timestamp(6) with time zone,
    CONSTRAINT "ToolsOnUsers_pkey" PRIMARY KEY ("userId", "toolId"),
    CONSTRAINT "ToolsOnUsers_toolId_fkey" FOREIGN KEY ("toolId")
        REFERENCES public."Tool" (id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT "ToolsOnUsers_userId_fkey" FOREIGN KEY ("userId")
        REFERENCES public."User" (id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
);





COMMIT;
