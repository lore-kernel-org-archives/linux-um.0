Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Message-Id: <200310062124.h96LONGj020833@ccure.karaya.com>
In-Reply-To: Your message of "Thu, 02 Oct 2003 19:13:54 +1200."
             <4.3.2.7.0.20031002191256.01667ef8@mail> 
References: <4.3.2.7.0.20031002191256.01667ef8@mail> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] Re: [uml-user] Fwd: spinlocks and cannot mount toms root
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Mon, 06 Oct 2003 17:24:23 -0400
To: "J. Cone" <jcone@eservglobal.com>
Cc: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

jcone@eservglobal.com said:
> I have what might be one or two problems with uml-2.6.0-test5-1: 
>   - there are several spin-lock errors late before the kernel tries to
> mount the root file-system
>   - toms root fails to mount

The spinlock problems have been known for a long time, and I haven't got
around to looking at them.

The diff doesn't seem to show toms failing to mount.

				Jeff



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
