Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CtMAV-0008GD-E8 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Jan 2005 00:35:23 -0800
Received: from mxfep02.bredband.com ([195.54.107.73])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CtMAT-0001DM-OL for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Jan 2005 00:35:23 -0800
Message-ID: <41F604BA.30008@better.se>
From: Marcus Better <marcus@better.se>
MIME-Version: 1.0
Subject: Re: [uml-devel] skas3 patch breaks ATI video drivers
References: <41F54FE9.7060503@better.se>
	<200501242113.16569.blaisorblade@yahoo.it>
In-Reply-To: <200501242113.16569.blaisorblade@yahoo.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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
Date: Tue, 25 Jan 2005 09:35:06 +0100
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

Blaisorblade wrote:

> I.e. the compilation problem is not in the kernel module, right?

Yes, the compilation error is in compiling the fglrx module.

> In this case, the problem is that you have /usr/include/asm symlinked to your kernel's 
> include/asm-i386 directory,

No, I don't, but I use Debian's make-kpkg which probably uses header 
files from the kernel tree. This is the normal method of building 
kernels on Debian, though.

I might add that I tried to fix the problem directly in the fglrx 
module, but it doesn't seem to work. It really must use the name 
modify_ldt in the macro, and this conflicts with the UML patch.

Marcus


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
