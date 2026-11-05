CREATE TABLE "deployment_logs" (
	"id" serial PRIMARY KEY,
	"deployment_id" integer NOT NULL,
	"seq" integer NOT NULL,
	"text" text NOT NULL,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "deployments" (
	"id" serial PRIMARY KEY,
	"project_id" integer NOT NULL,
	"commit_sha" text NOT NULL,
	"branch" text NOT NULL,
	"kind" text DEFAULT 'preview' NOT NULL,
	"status" text DEFAULT 'queued' NOT NULL,
	"url" text,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "domains" (
	"id" serial PRIMARY KEY,
	"project_id" integer NOT NULL,
	"hostname" text NOT NULL UNIQUE,
	"status" text DEFAULT 'pending' NOT NULL,
	"verification_token" text,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "env_vars" (
	"id" serial PRIMARY KEY,
	"project_id" integer NOT NULL,
	"key" text NOT NULL,
	"ciphertext" text NOT NULL,
	"iv" text NOT NULL,
	"updated_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "github_installations" (
	"installation_id" integer PRIMARY KEY,
	"account_login" text NOT NULL,
	"account_type" text DEFAULT 'User' NOT NULL,
	"installed_by_user_id" integer,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "platform_users" (
	"id" serial PRIMARY KEY,
	"github_id" text NOT NULL UNIQUE,
	"login" text NOT NULL,
	"avatar_url" text,
	"email" text,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "projects" (
	"id" serial PRIMARY KEY,
	"owner_user_id" integer NOT NULL,
	"name" text NOT NULL,
	"slug" text NOT NULL UNIQUE,
	"repo_owner" text NOT NULL,
	"repo_name" text NOT NULL,
	"repo_url" text NOT NULL,
	"branch" text DEFAULT 'main' NOT NULL,
	"production_branch" text DEFAULT 'main' NOT NULL,
	"framework" text,
	"install_command" text,
	"build_command" text,
	"output_dir" text,
	"start_command" text,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "webhook_events" (
	"id" serial PRIMARY KEY,
	"event" text NOT NULL,
	"repo_owner" text,
	"repo_name" text,
	"commit_sha" text,
	"signature_valid" boolean DEFAULT false NOT NULL,
	"received_at" timestamp DEFAULT now()
);
--> statement-breakpoint
ALTER TABLE "deployment_logs" ADD CONSTRAINT "deployment_logs_deployment_id_deployments_id_fkey" FOREIGN KEY ("deployment_id") REFERENCES "deployments"("id");--> statement-breakpoint
ALTER TABLE "deployments" ADD CONSTRAINT "deployments_project_id_projects_id_fkey" FOREIGN KEY ("project_id") REFERENCES "projects"("id");--> statement-breakpoint
ALTER TABLE "domains" ADD CONSTRAINT "domains_project_id_projects_id_fkey" FOREIGN KEY ("project_id") REFERENCES "projects"("id");--> statement-breakpoint
ALTER TABLE "env_vars" ADD CONSTRAINT "env_vars_project_id_projects_id_fkey" FOREIGN KEY ("project_id") REFERENCES "projects"("id");--> statement-breakpoint
ALTER TABLE "github_installations" ADD CONSTRAINT "github_installations_HeGkKNz41imJ_fkey" FOREIGN KEY ("installed_by_user_id") REFERENCES "platform_users"("id");--> statement-breakpoint
ALTER TABLE "projects" ADD CONSTRAINT "projects_owner_user_id_platform_users_id_fkey" FOREIGN KEY ("owner_user_id") REFERENCES "platform_users"("id");