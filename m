Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
From: Richard Weinberger <richard@nod.at>
Date: Mon, 23 Apr 2018 21:43:32 +0200
Message-ID: <63526108.WSV0FGAsac@blindfold>
In-Reply-To: <20180423182017.oxlfhnsrekk34q3b@K55DR>
References: <20180423182017.oxlfhnsrekk34q3b@K55DR>
MIME-Version: 1.0
Subject: Re: [uml-devel] [PATCH] um: remove uml initcalls
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/user-mode-linux-devel>, 
 <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>, 
 <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Alexander Pateenok <pateenoc@gmail.com>
Cc: Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
List-ID: <linux-um.lists.infradead.org>

Alexander,

Am Montag, 23. April 2018, 20:20:17 CEST schrieb Alexander Pateenok:
> __uml_initcall() is not used and .uml.initcall.init section is empty:
> 
> $ grep -r '__uml_initcall('
> arch/um/include/shared/init.h:#define __uml_initcall(fn)	\
> $ readelf -s ../umobj/linux | grep __uml_initcall
>  23214: 00000000603b75d8     0 NOTYPE  GLOBAL DEFAULT   32 __uml_initcall_start
>  25337: 00000000603b75d8     0 NOTYPE  GLOBAL DEFAULT   32 __uml_initcall_end
> 
> So it is unnecessary.

Right. The last user was removed almost 10 years ago by:
d2efa6d5ce14 ("uml: remove the dead TTY_LOG code")

Thanks,
//richard

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

