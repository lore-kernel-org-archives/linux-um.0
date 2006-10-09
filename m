Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GX73o-0003lR-0r for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 09 Oct 2006 19:09:36 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GX73n-000318-BE
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 09 Oct 2006 19:09:35 -0700
Date: Mon, 9 Oct 2006 14:00:13 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20061009180013.GB4931@ccure.user-mode-linux.org>
References: <20061005213212.17268.7409.stgit@memento.home.lan>
	<20061005213852.17268.13871.stgit@memento.home.lan>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20061005213852.17268.13871.stgit@memento.home.lan>
Subject: Re: [uml-devel] [PATCH 06/14] uml: make UML_SETJMP always safe
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
To: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Thu, Oct 05, 2006 at 11:38:52PM +0200, Paolo 'Blaisorblade' Giarrusso wrote:
> From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> 
> If enable is moved by GCC in a register its value may not be preserved after
> coming back there with longjmp(). So, mark it as volatile to prevent this; this
> is suggested (it seems) in info gcc, when it talks about -Wuninitialized. I
> re-read this and it seems to say something different, but I still believe this
> may be needed.
> 
> Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> ---
> 
>  arch/um/include/longjmp.h |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/um/include/longjmp.h b/arch/um/include/longjmp.h
> index e93c6d3..e860bc5 100644
> --- a/arch/um/include/longjmp.h
> +++ b/arch/um/include/longjmp.h
> @@ -12,7 +12,8 @@ #define UML_LONGJMP(buf, val) do { \
>  } while(0)
>  
>  #define UML_SETJMP(buf) ({ \
> -	int n, enable;	   \
> +	int n;	   \
> +	volatile int enable;	\
>  	enable = get_signals(); \
>  	n = setjmp(*buf); \
>  	if(n != 0) \

I agree with this, but not entirely with your reasoning.  The
-Wuninitialized documentation just talks about when gcc emits a
warning.

What we want is a guarantee that enable is not cached in a register,
but is stored in memory.  What documentation I can find seems to imply
that is the case ("accesses to volatile objects must have settled
before the next sequence point").

However, given the prevailing opinion that essentially all volatile
declarations are hiding bugs, I wouldn't mind a bit of review of this
from someone holding this opinion.

				Jeff

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
