Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AX9uF-00021i-Nw
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 18 Dec 2003 17:58:19 -0800
Received: from mta11.adelphia.net ([68.168.78.205])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AX9uF-0006NO-Ej
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 18 Dec 2003 17:58:19 -0800
From: Matt Zimmerman <mdz@debian.org>
Message-ID: <20031219015812.GS18100@alcor.net>
References: <1071789754.763978.973.nullmailer@nietzsche.wgtn.cat-it.co.nz> <20031219002949.GX18100@alcor.net> <3FE25502.2010205@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FE25502.2010205@catalyst.net.nz>
Subject: [uml-devel] Re: Bug#224431: user-mode-linux: Hangs
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 18 Dec 2003 17:58:12 -0800
To: Srdjan <srdjan@catalyst.net.nz>
Cc: user-mode-linux-devel@lists.sourceforge.net, 224431-forwarded@bugs.debian.org

On Fri, Dec 19, 2003 at 02:31:46PM +1300, Srdjan wrote:

> I seem to be able to connect to it:
> 
> srdjan@nietzsche:/plato-home/srdjan$ uml_mconsole wWko45
> (wWko45) config eth0
> ERR No get_config routine defined
> (wWko45) cad
> OK 
> 
> although cad didn't do anything.

What does "config con1" say?

> It worked yesterday with 2.4.22-5um-1, I only could not make network go,
> which I hoped to resolve today (but then I upgraded...:) I've installed
> kernel-patch-skas, but it refused to patch my 2.4.22 kernel. Any
> suggestions?

Make sure you have the latest version of kernel-patch-skas; that version
works fine with 2.4.22.

-- 
 - mdz


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
