Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CuYQd-0001Qm-GJ for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 Jan 2005 07:52:59 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CuYQ9-0001db-Gn for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 Jan 2005 07:52:59 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] skas3 patch breaks ATI video drivers
References: <41F54FE9.7060503@better.se>
	<200501251221.06303.blaisorblade@yahoo.it>
	<41FA4919.1040705@better.se>
In-Reply-To: <41FA4919.1040705@better.se>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501281652.04407.blaisorblade@yahoo.it>
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
Date: Fri, 28 Jan 2005 16:52:00 +0100
To: Marcus Better <marcus@better.se>, user-mode-linux-devel@lists.sourceforge.net

On Friday 28 January 2005 15:15, you wrote:
> Hi,
>
> > Ok, now I get it... they're trying to workaround the fact that
> > modify_ldt() is not exported.
> >
> > Thus they are probably violating the GPL

> I am under the impression that it is permitted to distribute a binary
> module, with only the "loader" under GPL.
No, I don't think so... the strict GPL interpretation is that you cannot 
distribute a non-GPL work which links with GPL code...

In fact, distributions cannot distribute GPL code linking with XFree 4.4.

What you probably see is that NVIDIA modules (and ATI ones too I guess, but I 
don't know well) have a binary-only part and a source-code part...

Linux developers mostly consider binary module to be ok until they are not 
"derivative works". And when a symbol is not exported, many times, it is 
because kernel developers feel that code using it is a derivative of the 
kernel.

In this case, it's maybe different - nobody thought that the sys_modify_ldt 
symbol should have been exported. That said, if somebody asked the question, 
the answer could be "No, it must not be exported, because modules using it 
are derivative works". On the other side, any userspace program can call the 
modify_ldt syscall.

> Do you mean that they are actually violating the license,
Well, just a rough feeling... I am not a lawyer.
> or that they 
> are evading the kernel's tainting mechanism?
> I suspect that they want to 
> avoid users getting the message about tainted kernels.
No, users will get the message, unless the module declares it self as "GPL" 
with a "MODULE_LICENSE("GPL") directive in the code, which it should not.
> If so, then I 
> would like to complain to them, because 1) it is disgusting behaviour
> and

> 2) it makes my life more difficult having to take care of their 
> stupid code.
For your specific problem, I'm applying your fix to next version of the SKAS 
patch (which I'm publishing anyway with other work). See my other mail. Not 
that it is a bug of the SKAS patch or of the ATI module alone.

For the GPL issue, you should probably ask to LKML (or post a letter to 
LWN.net about this issue - they could maybe publish it and you'd see the 
comments) or on slashdot.org (which is actually a discussion forum) - I have 
read discussions about such issues, but I'm not myself an expert.
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
