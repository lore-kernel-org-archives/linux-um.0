Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CtOU8-0006MI-57 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Jan 2005 03:03:48 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CtOU3-0000TS-Fh for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Jan 2005 03:03:48 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] skas3 patch breaks ATI video drivers
References: <41F54FE9.7060503@better.se>
	<200501251101.26981.blaisorblade@yahoo.it>
	<41F625BE.6050900@better.se>
In-Reply-To: <41F625BE.6050900@better.se>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501251221.06303.blaisorblade@yahoo.it>
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
Date: Tue, 25 Jan 2005 12:21:05 +0100
To: Marcus Better <marcus@better.se>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tuesday 25 January 2005 11:55, Marcus Better wrote:
> Blaisorblade wrote:
> > *strange* that a kernel module uses the "_syscall" macro to do a syscall
> > with "int 0x80" while already being in kernelspace...
>
> It's interesting that the module contains the following code:
>
> ------------------------
> //#define FGL_USE_SCT /* for developer use only */
>
> //...<snip>...
>
>
> #ifdef FGL_USE_SCT
> // get direct function pointers from sys_call_table for calling
> #else /* FGL_USE_SCT */
> // call functions indirectly by using the syscall macros,
> // entrypoints get defined by below constructs
>
> #if !defined(__ia64__)
> // the macros do use errno variable
> static int errno;
> #endif // __ia64__
>
> // int mlock(const void *addr, size_t len);
> _syscall2(int, mlock, const void *, addr, size_t, len )
> // int munlock(const void *addr, size_t len);
> _syscall2(int, munlock, const void *, addr, size_t, len )
> #if !defined(__ia64__)
> #if !defined(__x86_64__)
> // TODO: ia64
> // int modify_ldt(int func, void *ptr, unsigned long bytecount);
> _syscall3( int, modify_ldt, int, func, void *, ptr, unsigned long,
> bytecount )
> #endif
> #endif
> #endif /* FGL_USE_SCT */
> --------------------------

> I actually tried to #define FGL_USE_SCT, but it didn't compile either.
Ok, now I get it... they're trying to workaround the fact that modify_ldt() is 
not exported.

Thus they are probably violating the GPL (well, let's not start anything on 
this), because the syscall table has been unexported on purpose... however 
such tricks will break. I'll add the workaround in next revision, thanks (and 
if I forget, just mail me after the release).
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
