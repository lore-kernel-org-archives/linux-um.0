Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EiOMO-0000TC-Fm for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 Dec 2005 19:46:52 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EiOML-00058S-26
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 Dec 2005 19:46:52 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: 2.6.15-rc2
References: <12276.1133324450@sandelman.ottawa.on.ca>
	<200511301127.13494.rob@landley.net>
	<v0k6eo24af.fsf@marajade.sandelman.ca>
In-Reply-To: <v0k6eo24af.fsf@marajade.sandelman.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512030446.46310.blaisorblade@yahoo.it>
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
Date: Sat, 3 Dec 2005 04:46:45 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Michael Richardson <mcr@sandelman.ottawa.on.ca>, jdike@addtoit.com

On Thursday 01 December 2005 17:03, Michael Richardson wrote:
> okay, I don't quite understand, but it seemds that -rc2 is okay, but -rc3
> is failing. (-rc2 was failing as far as I could tell on Monday. Maybe I
> wasn't running the kernel I thought I was).

> Using git bisect, 

must learn that, yep...

> I've reduced the problem to: 

Yes, this happens due to GCC doing quite the opposite of what the patch should 
do, in the immediately following line. I've experienced this one too.

>           39d730ab87f07592e3a3794353f097d5184cae7a is first bad commit
>           diff-tree 39d730ab87f07592e3a3794353f097d5184cae7a (from

> Stub registers -

>         12 - bfffe092

This is the content of EIP.

> Kernel panic - not syncing: copy_context_skas0 : failed to wait for
> SIGUSR1/SIGTRAP, pid = 32345, n = 32345, errno = 0, status = 0xb7f

Ok - status = stopped for SIGSEGV.

> Program received signal SIGSEGV, Segmentation fault.

This backtrace is quite different from the other one - and checking for 
independent problems with cramfs may be worth... However, let's go back on 
main problem (below).

> zlib_inflateInit2_ (z=0xa0309360, w=15,
>     version=0xa280005c <Address 0xa280005c out of bounds>, stream_size=48)
>     at /mara1/git/uml-2.6.15/lib/zlib_inflate/inflate.c:57
> 57        z->state->blocks = NULL;
> (gdb) bt
> #0  zlib_inflateInit2_ (z=0xa0309360, w=15,
>     version=0xa280005c <Address 0xa280005c out of bounds>, stream_size=48)
>     at /mara1/git/uml-2.6.15/lib/zlib_inflate/inflate.c:57

Ok, here we replace the stack, in the below int 0x80. The old stack contents 
are not copied, and we have random crap on the new stack.

>   8a:	b8 c0 00 00 00       	mov    $0xc0,%eax
>   8f:	cd 80                	int    $0x80
>   91:	5d                   	pop    %ebp

Here we pop an invalid value into ebp - so we need to keep GCC from using %ebp 
afterwards.

This will fail. Notice the "92" - it matches last digits of EIP (the rest can 
change due to relocation, but the last digits are a good ID of the 
instruction).

>   92:	89 45 f0             	mov    %eax,0xfffffff0(%ebp)

%eax is the return value of the syscall. Gcc saves it on the stack and puts it 
back on %eax, but only with the patch.

>   95:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax

>   98:	a3 18 f0 ff bf       	mov    %eax,0xbffff018

The patch is intended to make sure the _above_ instruction is assembled 
correctly.


>   9d:	cc                   	int3
> 	trap_myself();
> }

The below is ignored thanks to the int3.

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.messenger.yahoo.com



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
