-- CreateTable
CREATE TABLE "organization" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "date_created" DATETIME NOT NULL,
    "last_modified" DATETIME NOT NULL
);

-- CreateTable
CREATE TABLE "role" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "user_id" INTEGER NOT NULL,
    "organization_id" INTEGER NOT NULL,
    "role_type" INTEGER NOT NULL,
    "date_created" DATETIME NOT NULL,
    "last_modified" DATETIME NOT NULL,
    CONSTRAINT "role_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "_user" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "role_organization_id_fkey" FOREIGN KEY ("organization_id") REFERENCES "organization" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "_user" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "google_profile_id" INTEGER NOT NULL,
    "role_id" INTEGER,
    "date_created" DATETIME NOT NULL,
    "last_modified" DATETIME NOT NULL,
    CONSTRAINT "_user_google_profile_id_fkey" FOREIGN KEY ("google_profile_id") REFERENCES "google_profile" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "google_profile" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "sub" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "given_name" TEXT NOT NULL,
    "family_name" TEXT NOT NULL,
    "picture" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "email_verified" BOOLEAN NOT NULL,
    "locale" TEXT NOT NULL,
    "hd" TEXT,
    "provider" TEXT NOT NULL,
    "date_created" DATETIME NOT NULL,
    "last_modified" DATETIME NOT NULL
);

-- CreateTable
CREATE TABLE "board" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "board_type" INTEGER NOT NULL,
    "backdrop_id" INTEGER,
    "user_id" INTEGER,
    "date_created" DATETIME NOT NULL,
    "last_modified" DATETIME NOT NULL,
    CONSTRAINT "board_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "_user" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "board_backdrop_id_fkey" FOREIGN KEY ("backdrop_id") REFERENCES "backdrop" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "position" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "position" INTEGER NOT NULL,
    "board_id" INTEGER NOT NULL,
    "channel_id" INTEGER NOT NULL,
    "date_created" DATETIME NOT NULL,
    "last_modified" DATETIME NOT NULL,
    CONSTRAINT "position_board_id_fkey" FOREIGN KEY ("board_id") REFERENCES "board" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "position_channel_id_fkey" FOREIGN KEY ("channel_id") REFERENCES "channel" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "backdrop" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "animated" BOOLEAN NOT NULL,
    "dark_mode" BOOLEAN NOT NULL,
    "date_created" DATETIME NOT NULL,
    "last_modified" DATETIME NOT NULL
);

-- CreateTable
CREATE TABLE "backdrop_color" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "value" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "channel" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "url" TEXT NOT NULL,
    "channel_type" INTEGER NOT NULL,
    "image" TEXT,
    "description" TEXT,
    "emoji" TEXT,
    "user_id" INTEGER,
    "organization_id" INTEGER,
    "date_created" DATETIME NOT NULL,
    "last_modified" DATETIME NOT NULL,
    CONSTRAINT "channel_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "_user" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "channel_organization_id_fkey" FOREIGN KEY ("organization_id") REFERENCES "organization" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "tag" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "user_id" INTEGER,
    "date_created" DATETIME NOT NULL,
    "last_modified" DATETIME NOT NULL,
    CONSTRAINT "tag_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "_user" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "_BackdropToBackdropColor" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL,
    FOREIGN KEY ("A") REFERENCES "backdrop" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY ("B") REFERENCES "backdrop_color" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "_ChannelToTag" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL,
    FOREIGN KEY ("A") REFERENCES "channel" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY ("B") REFERENCES "tag" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateIndex
CREATE UNIQUE INDEX "organization_slug_key" ON "organization"("slug");

-- CreateIndex
CREATE UNIQUE INDEX "role_user_id_key" ON "role"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "_user_google_profile_id_key" ON "_user"("google_profile_id");

-- CreateIndex
CREATE UNIQUE INDEX "google_profile_email_key" ON "google_profile"("email");

-- CreateIndex
CREATE UNIQUE INDEX "_BackdropToBackdropColor_AB_unique" ON "_BackdropToBackdropColor"("A", "B");

-- CreateIndex
CREATE INDEX "_BackdropToBackdropColor_B_index" ON "_BackdropToBackdropColor"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_ChannelToTag_AB_unique" ON "_ChannelToTag"("A", "B");

-- CreateIndex
CREATE INDEX "_ChannelToTag_B_index" ON "_ChannelToTag"("B");
