Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CtNF4-0002z8-7K for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Jan 2005 01:44:10 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CtNF0-00086G-7y for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Jan 2005 01:44:10 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] skas3 patch breaks ATI video drivers
References: <41F54FE9.7060503@better.se>
	<200501242113.16569.blaisorblade@yahoo.it>
	<41F604BA.30008@better.se>
In-Reply-To: <41F604BA.30008@better.se>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501251101.26981.blaisorblade@yahoo.it>
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
Date: Tue, 25 Jan 2005 11:01:26 +0100
To: Marcus Better <marcus@better.se>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tuesday 25 January 2005 09:35, Marcus Better wrote:
> Blaisorblade wrote:
> > I.e. the compilation problem is not in the kernel module, right?
>
> Yes, the compilation error is in compiling the fglrx module.
Ok, unexpected.
> > In this case, the problem is that you have /usr/include/asm symlinked to
> > your kernel's include/asm-i386 directory,
>
> No, I don't, but I use Debian's make-kpkg which probably uses header
> files from the kernel tree. This is the normal method of building
> kernels on Debian, though.
Well, since it is a kernel module, then it's correct...
> I might add that I tried to fix the problem directly in the fglrx
> module, but it doesn't seem to work.

> It really must use the name 
> modify_ldt in the macro
Yes, because the name in the macro is used to build the "__NR_modify_ldt"
> , and this conflicts with the UML patch.

Ok, this makes me wonder a bit... there is something which may cause conflicts 
in the UML patch (i.e. renaming modify_ldt that way), but it is very 
*strange* that a kernel module uses the "_syscall" macro to do a syscall with 
"int 0x80" while already being in kernelspace...

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
