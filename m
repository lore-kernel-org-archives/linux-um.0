Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Message-Id: <200404091626.i39GQqsf002414@ccure.user-mode-linux.org>
In-Reply-To: Your message of "Fri, 09 Apr 2004 14:47:32 +0200."
	<189201c41e30$d434cc70$2000000a@schlepptopp> 
References: <Pine.LNX.4.59.9.0404091209570.10714@hathi.bw-networx.net>
	<185d01c41e23$5996cc00$2000000a@schlepptopp>
	<189201c41e30$d434cc70$2000000a@schlepptopp> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] Re: [uml-user] Network lags
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
Date: Fri, 09 Apr 2004 12:26:52 -0400
To: roland <for_spam@gmx.de>
Cc: Joern Bredereck <jb@bw-networx.net>, user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net, mingo@elte.hu

for_spam@gmx.de said:
> at least, i would be interested in getting to know:
> - why this happens 
> - how to "tune" this, that it doesn`t happen 
> - if this is expected behavour on "heavy loaded systems" or probably a uml
> or host-kernel bug 

As you said, you're making life hard for the host.

My guess as to what's happening is this.

You're generating a ton of IO which is pulling the host's memory into page
cache.  This causes UML to get swapped out because it's not doing anything
except answering a ping once in a while.  When it does have to answer a ping,
it needs to be swapped back in, which might be hard since you're sucking down
a lot of IO bandwidth.

So, I don't think this says too much about whether anything's wrong with
either the host or UML.

Once thing you might try is do the same IO with O_DIRECT.  That won't pollute
the page cache.

				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
