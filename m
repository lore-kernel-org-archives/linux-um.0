Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C1wTg-0007Fl-OW for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 30 Aug 2004 17:26:24 -0700
Received: from gtfw2.enterasys.com ([12.25.1.128] ident=firewall-user)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1C1wTd-0003SN-KA for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 30 Aug 2004 17:26:24 -0700
Received: from NHROCAVG2.ets.enterasys.com (nhrocavg2.enterasys.com
	[134.141.79.124])
	by gtfw2.enterasys.com (0.25.1/8.12.6) with ESMTP id i7V0QDao012185
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 30 Aug 2004 20:26:13 -0400 (EDT)
Message-ID: <4133C57D.6060201@enterasys.com>
From: "D. Bahi" <dbahi@enterasys.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Re: [ann] kraxel's 2.6.8 uml patch kit
References: <20040820122445.GA21790@bytesex>
	<200408201901.i7KJ1eIF003843@ccure.user-mode-linux.org>
	<20040822111745.GA10736@bytesex>
In-Reply-To: <20040822111745.GA10736@bytesex>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigFE7DA9562CC69A669501C499"
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
Date: Mon, 30 Aug 2004 20:25:33 -0400
To: Gerd Knorr <kraxel@bytesex.org>
Cc: Jeff Dike <jdike@addtoit.com>, uml devel <user-mode-linux-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFE7DA9562CC69A669501C499
Content-Type: multipart/mixed; boundary="------------090007060204000801070109"

This is a multi-part message in MIME format.
--------------090007060204000801070109
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Gerd Knorr wrote:

> On Fri, Aug 20, 2004 at 03:01:40PM -0400, Jeff Dike wrote:
> 
>>kraxel@bytesex.org said:
>>
>>>uml-core-on-panic
>>>	Make the uml kernel dump core on kernel panics for later analysis.
>>>	Default: off, there is a kernel cmd line arg to enable that. 
>>
>>I like this, but I think it would be better done in a panic_notifier.
> 
> 
> I'll have a look.
> 

I liked this too. Here's a pass at it if you like (attached).
-- 
db

--------------090007060204000801070109
Content-Type: text/x-diff;
 name="core_on_panic.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="core_on_panic.patch"

diff -Naur linux.old/arch/um/kernel/reboot.c linux/arch/um/kernel/reboot.c
--- linux.old/arch/um/kernel/reboot.c	2004-08-30 16:38:37.000000000 -0400
+++ linux/arch/um/kernel/reboot.c	2004-08-30 16:38:51.000000000 -0400
@@ -38,21 +38,19 @@
 
 void uml_cleanup(void)
 {
-	kill_off_processes();
 	do_uml_exitcalls();
+	kill_off_processes();
 }
 
 void machine_restart(char * __unused)
 {
-	do_uml_exitcalls();
-	kill_off_processes();
+	uml_cleanup();
 	CHOOSE_MODE(reboot_tt(), reboot_skas());
 }
 
 void machine_power_off(void)
 {
-	do_uml_exitcalls();
-	kill_off_processes();
+	uml_cleanup();
 	CHOOSE_MODE(halt_tt(), halt_skas());
 }
 
@@ -69,5 +67,7 @@
  * ---------------------------------------------------------------------------
  * Local variables:
  * c-file-style: "linux"
+ * indent-tabs-mode: t
+ * tab-width: 8
  * End:
  */
diff -Naur linux.old/arch/um/kernel/um_arch.c linux/arch/um/kernel/um_arch.c
--- linux.old/arch/um/kernel/um_arch.c	2004-08-30 16:28:55.000000000 -0400
+++ linux/arch/um/kernel/um_arch.c	2004-08-30 18:20:53.000000000 -0400
@@ -412,9 +412,43 @@
 	.priority 		= 0
 };
 
+static int uml_coreonpanic = 0;
+
+static int coreonpanic_setup(char *str) {
+	printf("coreonpanic : Kernel will core on panic.\n");
+	uml_coreonpanic = 1;
+	return(0);
+}
+
+__setup("coreonpanic", coreonpanic_setup);
+__uml_help(coreonpanic_setup,
+"coreonpanic\n"
+"    This flag make it so that UML will dump core on a kernel panic or segfault.\n"
+"    Shell environment restrictions on cores (limit or ulimit) still apply.\n\n"
+"    Beware that your UML will not reboot with this flag.\n"
+);
+
+static int panic_coreonpanic(struct notifier_block *self, unsigned long unused1,
+			     void *unused2)
+{
+	if(uml_coreonpanic){
+		uml_cleanup();
+		block_signals();
+		abort();
+	}
+	return(0);		/* never get here */
+}
+
+static struct notifier_block panic_coreonpanic_notifier = {
+	.notifier_call 		= panic_coreonpanic,
+	.next 			= NULL,
+	.priority 		= 1
+};
+
 void __init setup_arch(char **cmdline_p)
 {
 	notifier_chain_register(&panic_notifier_list, &panic_exit_notifier);
+	notifier_chain_register(&panic_notifier_list, &panic_coreonpanic_notifier);
 	paging_init();
  	strcpy(command_line, saved_command_line);
  	*cmdline_p = command_line;
@@ -436,5 +470,7 @@
  * ---------------------------------------------------------------------------
  * Local variables:
  * c-file-style: "linux"
+ * indent-tabs-mode: t
+ * tab-width: 8
  * End:
  */

--------------090007060204000801070109--

--------------enigFE7DA9562CC69A669501C499
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (MingW32)

iD8DBQFBM8WC3XQ4zakZ3z4RAnmkAJ0TfG9k0swGkRp2G6P2NItpi88BnACfXGv9
nrs2OxsYB9oGCpTPntEriFs=
=ZoTc
-----END PGP SIGNATURE-----

--------------enigFE7DA9562CC69A669501C499--


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
