-- RedefineTables
CREATE TABLE "new_check_ins" (
    "id" serial NOT NULL PRIMARY KEY,
    "created_at" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "attendee_id" INTEGER NOT NULL,
    CONSTRAINT "check_ins_attendee_id_fkey" FOREIGN KEY ("attendee_id") REFERENCES "attendees" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO "new_check_ins" ("attendee_id", "created_at", "id") SELECT "attendee_id", "created_at", "id" FROM "check_ins";
ALTER TABLE "check_ins" DROP CONSTRAINT "check_ins_attendee_id_fkey";
DROP TABLE "check_ins" CASCADE;
ALTER TABLE "new_check_ins" RENAME TO "check_ins";
CREATE UNIQUE INDEX "check_ins_attendee_id_key" ON "check_ins"("attendee_id");
CREATE TABLE "new_attendees" (
    "id" serial NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "created_at" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "event_id" TEXT NOT NULL,
    CONSTRAINT "attendees_event_id_fkey" FOREIGN KEY ("event_id") REFERENCES "events" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO "new_attendees" ("created_at", "email", "event_id", "id", "name") SELECT "created_at", "email", "event_id", "id", "name" FROM "attendees";
ALTER TABLE "attendees" DROP CONSTRAINT "attendees_event_id_fkey";
DROP TABLE "attendees" CASCADE;
ALTER TABLE "new_attendees" RENAME TO "attendees";
CREATE UNIQUE INDEX "attendees_event_id_email_key" ON "attendees"("event_id", "email");