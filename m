Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ba13n-0004q7-Kx for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Jun 2004 16:40:15 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1Ba13m-0006Ha-W7 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Jun 2004 16:40:15 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] making uml work with smp
References: <40C8443B.8030809@auto.ucl.ac.be>
In-Reply-To: <40C8443B.8030809@auto.ucl.ac.be>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain; charset="iso-8859-1"
Message-Id: <200406142009.32436.blaisorblade_spam@yahoo.it>
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
Date: Mon, 14 Jun 2004 20:09:32 +0200
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Alle 13:21, gioved=EC 10 giugno 2004, Vincent Guffens ha scritto:
> Hi,

> The only changes that have to be made to compile with SMP is
>
> *add the folowing to  arch/um/config.in
>
>   define_bool CONFIG_SMP $CONFIG_UML_SMP
> +int 'Number of CPUs' CONFIG_NR_CPUS 1
>
> *change this line in arch/um/kernel/um_arch.c
> -int ncpus =3D 1;
> +int ncpus =3D 4;

No, please at least make CONFIG_NR_CPUS =3D=3D ncpus, PLEASE!

> *turn it on in the kernel config

Well, watch this code in the patch:

+void switch_mm_skas(int mm_fd)
+{
+       int err;
+
+#warning need cpu pid in switch_mm_skas
+       err =3D ptrace(PTRACE_SWITCH_MM, userspace_pid[0], 0, mm_fd);
+       if(err)
+               panic("switch_mm_skas - PTRACE_SWITCH_MM failed, errno =3D =

%d\n",
+                     errno);
+}
+
+void kill_off_processes_skas(void)
+{
+#warning need to loop over userspace_pids in kill_off_processes_skas
+       os_kill_process(userspace_pid[0], 1);
+}

userspace_pid[] is the array of the pids of the "userspace threads" (the=20
threads in T state, i.e. ptraced, which run the actual code of the guest=20
userspace). The warning complain that they should act onto the whole array.

Here, instead, you must use smp_processor_id() to determine which CPU you r=
un=20
on and then use it as userspace_pid index.

+int external_pid_skas(struct task_struct *task)
+{
+#warning Need to look up userspace_pid by cpu
+       return(userspace_pid[0]);
+}
+
+int thread_pid_skas(struct thread_struct *thread)
+{
+#warning Need to look up userspace_pid by cpu
+       return(userspace_pid[0]);
+}

Check any other usage of userspace_pid (on the code, not by debugging) and =

you've started solving the crashes. Then you can try again to see if there =
is=20
still something.

Bye
--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
