Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CRaOU-0007fc-Ce for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 09 Nov 2004 10:07:02 -0800
Received: from plam.fujitsu-siemens.com ([217.115.66.9])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CRaOS-0007mr-7R for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 09 Nov 2004 10:07:02 -0800
Message-ID: <41910740.3080301@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
References: <200411041932.39733.blaisorblade_spam@yahoo.it>
In-Reply-To: <200411041932.39733.blaisorblade_spam@yahoo.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: 2.6.9-bb1, 2.4.27-bs1, SKAS3/2.6-V7 released
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
Date: Tue, 09 Nov 2004 19:06:56 +0100
To: Blaisorblade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

Blaisorblade wrote:
> Any testing and report is welcome.
OK. 2.6.9-bb1 is a fine list of patches! The first tests as UML
are OK. At the moment, I saw one small problem only in
uml-refuse-to-run-if-no-tt-mode-in.patch
Use the following patch to fix it:

---

--- a/arch/um/kernel/um_arch.c	2004-11-09 18:27:10.343338760 +0100
+++ b/arch/um/kernel/um_arch.c	2004-11-09 18:27:21.676615840 +0100
@@ -314,7 +314,7 @@ int linux_main(int argc, char **argv)

  	mode_tt = force_tt ? 1 : !can_do_skas();
  #ifndef CONFIG_MODE_TT
-	if (!mode_tt) {
+	if (mode_tt) {
  		printf("Support for TT mode is disabled, and no SKAS support is present on the host.\n");
  		exit(1);
  	}





-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
