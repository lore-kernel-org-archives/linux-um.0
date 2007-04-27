Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HhTaj-0005bn-QD for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 27 Apr 2007 09:46:41 -0700
Received: from mail.nagafix.co.uk ([194.145.196.85])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HhTaj-0004di-4p
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 27 Apr 2007 09:46:41 -0700
Message-ID: <463228E5.6080904@nagafix.co.uk>
Date: Fri, 27 Apr 2007 17:46:29 +0100
From: Antoine Martin <antoine@nagafix.co.uk>
MIME-Version: 1.0
References: <462BACC9.7010303@nagafix.co.uk>	<20070425204849.GA9505@c2.user-mode-linux.org>	<462FC142.1010907@nagafix.co.uk>	<200704261612.40356.blaisorblade@yahoo.it>	<20070427151051.GB6019@c2.user-mode-linux.org>	<463214E7.5080605@nagafix.co.uk>	<20070427155024.GA8329@c2.user-mode-linux.org>
	<463224F8.6080009@nagafix.co.uk>
In-Reply-To: <463224F8.6080009@nagafix.co.uk>
Subject: Re: [uml-devel] regression: pcap broken in 2.6.20.x
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Antoine Martin <antoine@nagafix.co.uk>
Cc: Jeff Dike <jdike@addtoit.com>, Blaisorblade <blaisorblade@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Antoine Martin wrote:
> Jeff Dike wrote:
>> On Fri, Apr 27, 2007 at 04:21:11PM +0100, Antoine Martin wrote:
>>> Question remains as to why the mac address was the same until 2.6.20 and
>>> is now different.
>> We started providing randomized MACs at bootup instead of deriving
>> them from the IP when the interface was brought up.  The old behavior
>> broke when distros started bringing interfaces up without assigning
>> IPs to them.
> 
>>> Except, pcap doesn't have the option.
>> Hmmm that would be a problem.
> :)
> I've got a patch - coming soon (tm)
Attached.

Not sure which approach is best:

1) this one requires a command line like:
"vmlinux eth0=pcap,eth0,,mac=00:01:02:03:04:05"

- --- a/arch/um/drivers/pcap_kern.c   2007-02-04 18:44:54.000000000 +0000
+++ b/arch/um/drivers/pcap_kern.c   2007-04-27 17:40:15.000000000 +0100
@@ -15,6 +15,7 @@
        int promisc;
        int optimize;
        char *filter;
+       char *mac;
 };

 void pcap_init(struct net_device *dev, void *data)
@@ -56,17 +57,18 @@
 int pcap_setup(char *str, char **mac_out, void *data)
 {
        struct pcap_init *init = data;
- -       char *remain, *host_if = NULL, *options[2] = { NULL, NULL };
+       char *remain, *host_if = NULL, *options[3] = { NULL, NULL, NULL };
        int i;

        *init = ((struct pcap_init)
                { .host_if      = "eth0",
                  .promisc      = 1,
                  .optimize     = 0,
- -                 .filter       = NULL });
+                 .filter       = NULL,
+                 .mac          = "00:00:00:00:00:00" });

        remain = split_if_spec(str, &host_if, &init->filter,
- -                              &options[0], &options[1], NULL);
+                              &options[0], &options[1], &options[2], NULL);
        if(remain != NULL){
                printk(KERN_ERR "pcap_setup - Extra garbage on "
                       "specification : '%s'\n", remain);
@@ -87,6 +89,10 @@
                        init->optimize = 1;
                else if(!strcmp(options[i], "nooptimize"))
                        init->optimize = 0;
+               else if(!strncmp(options[i], "mac=", 4) &&
strlen(options[i])==21) {
+                       strncpy(init->mac, options[i]+4, 17);
+                       *mac_out = init->mac;
+               }
                else printk("pcap_setup : bad option - '%s'\n", options[i]);
        }



2) or this one: which just assumes that the mac address is any option
that isn't [no]promisc or [no]optimize and is 17 characters long (I
don't see much point in doing extra checks since this is check in
setup_ether_xx later on)

- --- /uml/kernels/src/linux-2.6.20.9-amd64/arch/um/drivers/pcap_kern.c
2007-02-04 18:44:54.000000000 +0000
+++ pcap_kern.c 2007-04-27 17:45:31.000000000 +0100
@@ -15,6 +15,7 @@
        int promisc;
        int optimize;
        char *filter;
+       char *mac;
 };

 void pcap_init(struct net_device *dev, void *data)
@@ -56,17 +57,18 @@
 int pcap_setup(char *str, char **mac_out, void *data)
 {
        struct pcap_init *init = data;
- -       char *remain, *host_if = NULL, *options[2] = { NULL, NULL };
+       char *remain, *host_if = NULL, *options[3] = { NULL, NULL, NULL };
        int i;

        *init = ((struct pcap_init)
                { .host_if      = "eth0",
                  .promisc      = 1,
                  .optimize     = 0,
- -                 .filter       = NULL });
+                 .filter       = NULL,
+                 .mac          = "00:00:00:00:00:00" });

        remain = split_if_spec(str, &host_if, &init->filter,
- -                              &options[0], &options[1], NULL);
+                              &options[0], &options[1], &options[2], NULL);
        if(remain != NULL){
                printk(KERN_ERR "pcap_setup - Extra garbage on "
                       "specification : '%s'\n", remain);
@@ -87,6 +89,11 @@
                        init->optimize = 1;
                else if(!strcmp(options[i], "nooptimize"))
                        init->optimize = 0;
+               else if(strlen(options[i])==17) {
+                       //a mac address is always 17 characters long
+                       strncpy(init->mac, options[i], 17);
+                       *mac_out = init->mac;
+               }
                else printk("pcap_setup : bad option - '%s'\n", options[i]);
        }
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGMijlGK2zHPGK1rsRCp1LAJ4wKs6o+Wv8dd2VCUO1Zd9jKKhoywCdF9FK
P6meCx9gwAFlI2+JelLDB7U=
=Yzfw
-----END PGP SIGNATURE-----

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
