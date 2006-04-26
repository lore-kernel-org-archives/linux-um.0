Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FYbHT-0008SQ-PE for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Apr 2006 21:05:35 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FYbHT-0006vW-Q5 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Apr 2006 21:05:35 -0700
Received: from [216.99.212.251] (helo=mail.omegacs.net)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FYbHS-0002bI-LT
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Apr 2006 21:05:35 -0700
Received: from [10.1.1.3] (omicron [10.1.1.3])
	by mail.omegacs.net (8.11.6/8.11.0) with ESMTP id k3Q4d1q02611
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 25 Apr 2006 21:39:01 -0700
Message-ID: <444EF18C.2080903@vcolo.com>
From: Erik Walthinsen <omega@vcolo.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060706040101040108050605"
Subject: [uml-devel] [RFC][PATCH] Converting mconsole to SOCK_STREAM
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Tue, 25 Apr 2006 21:05:32 -0700
To: user-mode-linux-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------060706040101040108050605
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

We (Vcolo.com, formerly pdxcolo.net) have been running with a variation on 
the attached patch from day one.  I figure it's probably time to see if it 
should be included in the main distribution finally, especially since the 
API has now changed enough that moving it to 2.6.16 is going to get interesting.

The premise is simple: mconsole should be SOCK_STREAM.  In our case, this is 
used to detect the shutdown of the machine by simply polling for the control 
socket to close.  It's saved us from all kinds of potentially bizarre 
polling modes, so it's been well worth it.

The patch has worked fine so far, but I've never been satisfied with the way 
I kinda had to hack it into place without *fully* understanding the whole 
channel IRQ setup.  Since 2.6.16 changed how that works, I'm now at the 
point where I need more expert advise, hopefully along the way to putting 
this into the mainstream UML kernel.

Also attached is a version of uml_mconsole.c, forked who knows back when 
(~3yrs ago) so I'll have to dig out a file later to diff it against.  The 
only changes that should be in that file are switching to SOCK_STREAM and 
read()/write() instead of recv()/sendto().

Whether this is something that belongs in the main UML kernel or not, I 
would much appreciate it if someone has the time to help me to make sure the 
soft-IRQ handling is sane while moving it to the 2.6.16 codebase.

The patch is against 2.6.15.6 with uml-2.6.15-bs3-tls.patch.  There might be 
some minor line offset fuzz from some other local patches.

TIA,
    Omega
    aka Erik Walthinsen
    omega@vcolo.com

--------------060706040101040108050605
Content-Type: text/plain;
 name="stream-2.6.15.6-bs3-tls.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="stream-2.6.15.6-bs3-tls.diff"

diff -urN linux-2.6.15.6-bs3-tls/arch/um/drivers/mconsole_kern.c linux-2.6.15.6-bs3-tls-stream/arch/um/drivers/mconsole_kern.c
--- linux-2.6.15.6-bs3-tls/arch/um/drivers/mconsole_kern.c	2006-04-25 20:26:57.000000000 -0700
+++ linux-2.6.15.6-bs3-tls-stream/arch/um/drivers/mconsole_kern.c	2006-04-25 20:51:21.000000000 -0700
@@ -72,16 +72,30 @@
 
 DECLARE_WORK(mconsole_work, mc_work_proc, NULL);
 
+static int mconsole_listen_sock = 0;
+static char *notify_socket = NULL;
+
 static irqreturn_t mconsole_interrupt(int irq, void *dev_id,
 				      struct pt_regs *regs)
 {
 	/* long to avoid size mismatch warnings from gcc */
 	long fd;
+	int err;
 	struct mconsole_entry *new;
 	struct mc_request req;
 
 	fd = (long) dev_id;
-	while (mconsole_get_request(fd, &req)){
+	while ((err = mconsole_get_request(fd, &req)) >= 0) {
+		/* if we got back and end-of-file, close off this client */
+		if (err == 0) {
+			free_irq_later(MCONSOLE_CLIENT_IRQ, (void *)fd);
+			close(fd);
+			return(IRQ_HANDLED);
+		}
+
+		/* if there is no valid command, don't chase it down */
+		if (! req.cmd) continue;
+
 		if(req.cmd->context == MCONSOLE_INTR)
 			(*req.cmd->handler)(&req);
 		else {
@@ -96,7 +110,37 @@
 	}
 	if(!list_empty(&mc_requests))
 		schedule_work(&mconsole_work);
-	reactivate_fd(fd, MCONSOLE_IRQ);
+	reactivate_fd(fd, MCONSOLE_CLIENT_IRQ);
+	return(IRQ_HANDLED);
+}
+
+void mconsole_accept_task_proc(void *unused)
+{
+	int fd;
+	unsigned long flags;
+
+	local_save_flags(flags);
+
+	while ((fd = os_accept_unix_stream_socket(mconsole_listen_sock)) >= 0) {
+		if (um_request_irq(MCONSOLE_CLIENT_IRQ, fd, IRQ_READ, mconsole_interrupt,
+				   SA_INTERRUPT | SA_SHIRQ | SA_SAMPLE_RANDOM,
+				   "mconsole", (void *)fd)) {
+			printk(KERN_ERR "mconsole_accept_task_proc: failed to get IRQ for client %d\n",fd);
+			local_irq_restore(flags);
+			return;
+		}
+	}
+
+	reactivate_fd(mconsole_listen_sock, MCONSOLE_IRQ);
+
+	local_irq_restore(flags);
+}
+
+DECLARE_WORK(mconsole_accept_task, mconsole_accept_task_proc, NULL);
+
+static irqreturn_t mconsole_accept_interrupt(int irq, void *data, struct pt_regs *regs)
+{
+	schedule_work(&mconsole_accept_task);
 	return(IRQ_HANDLED);
 }
 
@@ -563,29 +607,34 @@
 /* Changed by mconsole_setup, which is __setup, and called before SMP is
  * active.
  */
-static char *notify_socket = NULL; 
+//static char *notify_socket = NULL; 
 
 int mconsole_init(void)
 {
 	/* long to avoid size mismatch warnings from gcc */
-	long sock;
+//	long sock;
 	int err;
 	char file[256];
 
 	if(umid_file_name("mconsole", file, sizeof(file))) return(-1);
 	snprintf(mconsole_socket_name, sizeof(file), "%s", file);
 
-	sock = os_create_unix_socket(file, sizeof(file), 1);
-	if (sock < 0){
+//	sock = os_create_unix_socket(file, sizeof(file), 1);
+//	if (sock < 0){
+	mconsole_listen_sock = os_create_unix_stream_socket(file, sizeof(file), 1);
+	if (mconsole_listen_sock < 0){
 		printk("Failed to initialize management console\n");
 		return(1);
 	}
 
 	register_reboot_notifier(&reboot_notifier);
 
-	err = um_request_irq(MCONSOLE_IRQ, sock, IRQ_READ, mconsole_interrupt,
+//	err = um_request_irq(MCONSOLE_IRQ, sock, IRQ_READ, mconsole_interrupt,
+//			     SA_INTERRUPT | SA_SHIRQ | SA_SAMPLE_RANDOM,
+//			     "mconsole", (void *)sock);
+	err = um_request_irq(MCONSOLE_IRQ, mconsole_listen_sock, IRQ_READ, mconsole_accept_interrupt,
 			     SA_INTERRUPT | SA_SHIRQ | SA_SAMPLE_RANDOM,
-			     "mconsole", (void *)sock);
+			     "mconsole", (void *)mconsole_listen_sock);
 	if (err){
 		printk("Failed to get IRQ for management console\n");
 		return(1);
diff -urN linux-2.6.15.6-bs3-tls/arch/um/drivers/mconsole_user.c linux-2.6.15.6-bs3-tls-stream/arch/um/drivers/mconsole_user.c
--- linux-2.6.15.6-bs3-tls/arch/um/drivers/mconsole_user.c	2006-04-25 20:26:57.000000000 -0700
+++ linux-2.6.15.6-bs3-tls-stream/arch/um/drivers/mconsole_user.c	2006-04-25 20:28:30.000000000 -0700
@@ -84,10 +84,14 @@
 	int len;
 
 	req->originlen = sizeof(req->origin);
-	req->len = recvfrom(fd, &req->request, sizeof(req->request), 0,
-			    (struct sockaddr *) req->origin, &req->originlen);
-	if (req->len < 0)
+//	req->len = recvfrom(fd, &req->request, sizeof(req->request), 0,
+//			    (struct sockaddr *) req->origin, &req->originlen);
+	req->len = read(fd, &req->request, sizeof(req->request));
+
+	if (req->len == 0)
 		return 0;
+	else if (req->len < 0)
+		return -1;
 
 	req->originating_fd = fd;
 
@@ -151,8 +155,9 @@
 
 		len = sizeof(reply) + reply.len - sizeof(reply.data);
 
-		n = sendto(req->originating_fd, &reply, len, 0,
-			   (struct sockaddr *) req->origin, req->originlen);
+//		n = sendto(req->originating_fd, &reply, len, 0,
+//			   (struct sockaddr *) req->origin, req->originlen);
+		n = write(req->originating_fd, &reply, len);
 
 		if(n < 0) return(-errno);
 	} while(total > 0);
diff -urN linux-2.6.15.6-bs3-tls/arch/um/include/os.h linux-2.6.15.6-bs3-tls-stream/arch/um/include/os.h
--- linux-2.6.15.6-bs3-tls/arch/um/include/os.h	2006-04-25 20:26:57.000000000 -0700
+++ linux-2.6.15.6-bs3-tls-stream/arch/um/include/os.h	2006-04-25 20:28:30.000000000 -0700
@@ -146,6 +146,8 @@
 extern int os_set_fd_block(int fd, int blocking);
 extern int os_accept_connection(int fd);
 extern int os_create_unix_socket(char *file, int len, int close_on_exec);
+extern int os_create_unix_stream_socket(char *file, int len, int close_on_exec);
+extern int os_accept_unix_stream_socket(int fd);
 extern int os_shutdown_socket(int fd, int r, int w);
 extern void os_close_file(int fd);
 extern int os_rcv_fd(int fd, int *helper_pid_out);
diff -urN linux-2.6.15.6-bs3-tls/arch/um/os-Linux/file.c linux-2.6.15.6-bs3-tls-stream/arch/um/os-Linux/file.c
--- linux-2.6.15.6-bs3-tls/arch/um/os-Linux/file.c	2006-01-02 19:21:10.000000000 -0800
+++ linux-2.6.15.6-bs3-tls-stream/arch/um/os-Linux/file.c	2006-04-25 20:28:30.000000000 -0700
@@ -617,6 +617,55 @@
 	return(sock);
 }
 
+int os_create_unix_stream_socket(char *file, int len, int close_on_exec)
+{
+	struct sockaddr_un addr;
+	int sock, err;
+
+	sock = socket(PF_UNIX, SOCK_STREAM, 0);
+	if (sock < 0){
+		printk("create_unix_socket - socket failed, errno = %d\n",
+		       errno);
+		return(-errno);
+	}
+
+	if(close_on_exec) {
+		err = os_set_exec_close(sock, 1);
+		if(err < 0)
+			printk("create_unix_socket : close_on_exec failed, "
+		       "err = %d", -err);
+	}
+
+	addr.sun_family = AF_UNIX;
+
+	/* XXX Be more careful about overflow */
+	snprintf(addr.sun_path, len, "%s", file);
+
+	err = bind(sock, (struct sockaddr *) &addr, sizeof(addr));
+	if (err < 0){
+		printk("create_listening_socket at '%s' - bind failed, "
+		       "errno = %d\n", file, errno);
+		return(-errno);
+	}
+
+	listen(sock, 1);
+
+	return(sock);
+}
+
+int os_accept_unix_stream_socket(int fd)
+{
+	int newfd;
+
+	/* accept the new client */
+	newfd = accept(fd,NULL,NULL);
+
+	/* we have to make it non-blocking here */
+	fcntl(newfd,F_SETFL,O_NONBLOCK);
+
+	return newfd;
+}
+
 void os_flush_stdout(void)
 {
 	fflush(stdout);
diff -urN linux-2.6.15.6-bs3-tls/include/asm-um/irq.h linux-2.6.15.6-bs3-tls-stream/include/asm-um/irq.h
--- linux-2.6.15.6-bs3-tls/include/asm-um/irq.h	2006-01-02 19:21:10.000000000 -0800
+++ linux-2.6.15.6-bs3-tls-stream/include/asm-um/irq.h	2006-04-25 20:28:30.000000000 -0700
@@ -15,8 +15,9 @@
 #define SIGIO_WRITE_IRQ 	11
 #define TELNETD_IRQ 		12
 #define XTERM_IRQ 		13
+#define MCONSOLE_CLIENT_IRQ	14
 
-#define LAST_IRQ XTERM_IRQ
+#define LAST_IRQ MCONSOLE_CLIENT_IRQ
 #define NR_IRQS (LAST_IRQ + 1)
 
 #endif

--------------060706040101040108050605
Content-Type: text/x-csrc;
 name="uml_mconsole.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="uml_mconsole.c"

/* Copyright 2001 Jeff Dike and others
 * Licensed under the GPL
 */

#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <errno.h>
#include <ctype.h>
#include <stdint.h>
#include <sys/stat.h>
#include <sys/param.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <sys/uio.h>
#include <readline/readline.h>
#include <readline/history.h>

static char uml_name[11];
static struct sockaddr_un sun;

static int do_switch(char *file, char *name)
{
  struct stat buf;

  if(stat(file, &buf) == -1){
    fprintf(stderr, "Warning: couldn't stat file: %s - ", file);
    perror("");
    return(-1);
  }
  sun.sun_family = AF_UNIX;
  strncpy(sun.sun_path, file, sizeof(sun.sun_path));
  strncpy(uml_name, name, sizeof(uml_name));
  return(0);
}

static int switch_common(char *name)
{
  char file[MAXPATHLEN + 1], dir[MAXPATHLEN + 1], tmp[MAXPATHLEN + 1], *home;
  int try_file = 1;

  if((home = getenv("HOME")) != NULL){
    snprintf(dir, sizeof(dir), "%s/.uml", home);
    snprintf(file, sizeof(file), "%s/%s/mconsole", dir, name);
    if(strncmp(name, dir, strlen(dir))){
      if(!do_switch(file, name)) return(0);
      try_file = 0;
    }
  }

  snprintf(tmp, sizeof(tmp), "/tmp/uml/%s/mconsole", name);
  if(strncmp(name, "/tmp/uml/", strlen("/tmp/uml/"))){
    if(!do_switch(tmp, name)) return(0);
  }

  if(!do_switch(name, name)) return(0);
  if(!try_file) return(-1);
  return(do_switch(file, name));
}

#define MCONSOLE_MAGIC (0xcafebabe)
#define MCONSOLE_MAX_DATA (512)
#define MCONSOLE_VERSION (2)

#ifndef MIN
#define MIN(a,b) ((a)<(b) ? (a):(b))
#endif

struct mconsole_request {
	uint32_t magic;
	uint32_t version;
	uint32_t len;
	char data[MCONSOLE_MAX_DATA];
};

struct mconsole_reply {
	uint32_t err;
	uint32_t more;
	uint32_t len;
	char data[MCONSOLE_MAX_DATA];
};

static char *absolutize(char *to, int size, char *from)
{
  char save_cwd[MAXPATHLEN + 1], *slash;
  int remaining;

  if(getcwd(save_cwd, sizeof(save_cwd)) == NULL) {
    perror("absolutize : unable to get cwd");
    return(NULL);
  }
  slash = strrchr(from, '/');
  if(slash != NULL){
    *slash = '\0';
    if(chdir(from)){
      *slash = '/';
      fprintf(stderr, "absolutize : Can't cd to '%s'", from);
      perror("");
      return(NULL);
    }
    *slash = '/';
    if(getcwd(to, size) == NULL){
      fprintf(stderr, "absolutize : unable to get cwd of '%s'", from);
      perror("");
      return(NULL);
    }
    remaining = size - strlen(to);
    if(strlen(slash) + 1 > remaining){
      fprintf(stderr, "absolutize : unable to fit '%s' into %d chars\n", from,
	      size);
      return(NULL);
    }
    strcat(to, slash);
  }
  else {
    if(strlen(save_cwd) + 1 + strlen(from) + 1 > size){
      fprintf(stderr, "absolutize : unable to fit '%s' into %d chars\n", from,
	      size);
      return(NULL);
    }
    strcpy(to, save_cwd);
    strcat(to, "/");
    strcat(to, from);
  }
  chdir(save_cwd);
  return(to);
}

static int fix_filenames(char **cmd_ptr)
{
  char *cow_file, *backing_file, *equal, *new, *ptr = *cmd_ptr;
  char full_backing[MAXPATHLEN + 1], full_cow[MAXPATHLEN + 1];
  int len;

  if(strncmp(ptr, "config", strlen("config"))) return(0);
  ptr += strlen("config");

  while(isspace(*ptr) && (*ptr != '\0')) ptr++;
  if(*ptr == '\0') return(0);

  if(strncmp(ptr, "ubd", strlen("ubd"))) return(0);

  while((*ptr != '=') && (*ptr != '\0')) ptr++;
  if(*ptr == '\0') return(0);

  equal = ptr;
  cow_file = ptr + 1;
  while((*ptr != ',') && (*ptr != '\0')) ptr++;
  if(*ptr == '\0'){
    backing_file = cow_file;
    cow_file = NULL;
  }
  else {
    *ptr = '\0';
    backing_file = ptr + 1;
  }

  ptr = absolutize(full_backing, sizeof(full_backing), backing_file);
  backing_file = ptr ? ptr : backing_file;

  if(cow_file != NULL){
    ptr = absolutize(full_cow, sizeof(full_cow), cow_file);
    cow_file = ptr ? ptr : cow_file;
  }

  len = equal - *cmd_ptr;
  len += strlen("=") + strlen(backing_file) + 1;
  if(cow_file != NULL){
    len += strlen(",") + strlen(cow_file);
  }

  new = malloc(len * sizeof(char));
  if(new == NULL) return(0);

  strncpy(new, *cmd_ptr, equal - *cmd_ptr);
  ptr = new + (equal - *cmd_ptr);
  *ptr++ = '=';

  if(cow_file != NULL){
    sprintf(ptr, "%s,", cow_file);
    ptr += strlen(ptr);
  }
  strcpy(ptr, backing_file);

  *cmd_ptr = new;
  return(1);
}

static void default_cmd(int fd, char *command)
{
  struct mconsole_request request;
  struct mconsole_reply reply;
  char name[128];
  int n, free_command;

  if((sscanf(command, "%128[^: \f\n\r\t\v]:", name) == 1) &&
     (*(name + 1) == ':')){
    if(switch_common(name)) return;
    command = strchr(command, ':');
    *command++ = '\0';
    while(isspace(*command)) command++;
  }

  free_command = fix_filenames(&command);

  request.magic = MCONSOLE_MAGIC;
  request.version = MCONSOLE_VERSION;
  request.len = MIN(strlen(command), sizeof(reply.data) - 1);
  strncpy(request.data, command, request.len);
  request.data[request.len] = '\0';

  if(free_command) free(command);

//  if(sendto(fd, &request, sizeof(request), 0, (struct sockaddr *) &sun, 
//	    sizeof(sun)) < 0){

  sleep(1);
  if (write(fd,&request,sizeof(request)) < 0) {
    fprintf(stderr, "Sending command to '%s' : ", sun.sun_path);
    perror("");
    return;
  }
  
  do {
    int len = sizeof(sun);
//    n = recvfrom(fd, &reply, sizeof(reply), 0, (struct sockaddr *) &sun, &len);
    n = read(fd,&reply,sizeof(reply));
    if(n < 0){
      perror("recvmsg");
      return;
    }
    if(reply.err) printf("ERR ");
    else printf("OK ");
    printf("%s", reply.data);
  } while(reply.more);

  printf("\n");
}

static void help_cmd(int fd, char *command)
{
  default_cmd(fd, command);
  printf("Additional local mconsole commands:\n");
  printf("    quit - Quit mconsole\n");
  printf("    switch <socket-name> - Switch control to the given machine\n");
}

static void switch_cmd(int fd, char *command)
{
  char *ptr;

  ptr = &command[strlen("switch")];
  while(isspace(*ptr)) ptr++;
  if(switch_common(ptr)) return;
  printf("Switched to '%s'\n", ptr);
}

static void quit_cmd(int fd, char *command)
{
  exit(0);
}

struct cmd {
  char *command;
  void (*proc)(int, char *);
};

static struct cmd cmds[] = {
  { "quit", quit_cmd },
  { "help", help_cmd },
  { "switch", switch_cmd },
  { NULL, default_cmd }
};

/* sends a command */
int issue_command(int fd, char *command)
{
  char *ptr;
  int i;

  /* Trim trailing spaces left by readline's filename completion */
  ptr = &command[strlen(command) - 1];
  while(isspace(*ptr)) *ptr-- = '\0';
    
  for(i = 0; i < sizeof(cmds)/sizeof(cmds[0]); i++){
    if((cmds[i].command == NULL) || 
       !strncmp(cmds[i].command, command, strlen(cmds[i].command))){
      (*cmds[i].proc)(fd, command);
      break;
    }
  }
    
  /* in future, return command status */
  return 0;
}

/* sends a command in argv style array */
int issue_commandv(int fd, char **argv)
{
  char *command;
  int len, i, status;

  len = 1;  /* space for trailing null */
  for(i = 0; argv[i] != NULL; i++)
    len += strlen(argv[i]) + 1;  /* space for space */

  command = malloc(len);
  if(command == NULL){
    perror("issue_command");
    return(-1);
  }
  command[0] = '\0';

  for(i = 0; argv[i] != NULL; i++) {
    strcat(command, argv[i]);
    if(argv[i+1] != NULL) strcat(command, " ");
  }

  status = issue_command(fd, command);

  free(command);

  return status;
}

static void Usage(void)
{
  fprintf(stderr, "Usage : uml_mconsole socket-name [command]\n");
  exit(1);
}

int main(int argc, char **argv)
{
  char *sock;
  int fd;

  if(argc < 2) Usage();
  strcpy(uml_name, "[None]");
  sock = argv[1];
  switch_common(sock);

  fprintf(stderr,"going to open '%s'\n",sock);

  if((fd = socket(AF_UNIX, SOCK_STREAM, 0)) < 0){
    perror("socket");
    exit(1);
  }
  if(connect(fd, (struct sockaddr *) &sun, sizeof(sun)) < 0){
    perror("connect");
    exit(1);
  }

  if(argc>2)
    return issue_commandv(fd, argv+2);

  while(1){
    char *command, prompt[1 + sizeof(uml_name) + 2 + 1];

    sprintf(prompt, "(%s) ", uml_name);
    command = readline(prompt);
    if(command == NULL) break;

    if(*command) add_history(command);

    issue_command(fd, command);
    free(command);
  }
  printf("\n");
  return(0);
}

--------------060706040101040108050605--


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
