Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CrxCi-0007LS-6X for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 21 Jan 2005 03:43:52 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CrxCd-0006g9-AO for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 21 Jan 2005 03:43:52 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] UML - stalling during large file transfers
References: <41F0A696.8050201@printsoft.com>
In-Reply-To: <41F0A696.8050201@printsoft.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501211255.59809.blaisorblade@yahoo.it>
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
Date: Fri, 21 Jan 2005 12:55:59 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Gerhard Hannemann <gerhard.hannemann@printsoft.com>

On Friday 21 January 2005 07:52, Gerhard Hannemann wrote:
> Encountered a baffling problem while copying large amounts of files from
> a archive (*.tbz) or from a remote system to a directory within a
> running UML system. The UML stalls while the IDE hardrive thrashes along
> for server minutes. It recovers, continues on with some more files, and
> stall again. While this is happening, all maternity's connected to that
> UML just freeze.
> The host system is perfectly accessible and on show minimal CPU usages.
> A running top session within the UML also show low CPU and moderate
> memory usage. However the UML's load increases up to 3.x for several
> minutes and then recovers.
> System Data:
>
>       Host:
>       AMD Athlon 2.1Ghz running Gentoo using 2.6.9 kernel with skas3 patch.
>       1 SCSI 18G drive (boot drive) and one IDE 15G drive.
>       1G tmpfs
>       UML:
>       Vanilla 2.4.27 UML kernel (patched of UML usage)
>       3G file system and 512M swap.
>       The UML is run using 512M of mem.
>       The UML runs from the IDE drive.

I've just read the beginning, however I suspect you are running a 
not-up-to-date UML with the kernel option "CONFIG_BLK_DEV_UBD_SYNC" or the 
option "ubd=sync" on the command line. Until a little time ago, that meaned 
that the write requests (which are synchronous) were executed by the UML 
kernel and not by the separate thread used normally.

The workaround is to recompile disabling that option, and adding for each UBD 
the 's' option (i.e. ubd0= becomes ubd0s= and so on). So, you still get the 
safety without the slowdown.

This workaround is not needed in recent UML versions (for instance 2.6.9-bs5 
is surely ok, I don't remember if stock 2.6.9 already has the fix). The fix 
has not yet been backported to 2.4 (although it's easy).
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
