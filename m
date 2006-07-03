Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Message-ID: <20060703103313.06igshf1vd44kokk@mail.admindu.de>
Date: Mon, 03 Jul 2006 10:33:13 +0200
From: Daniel Tombeil <dt@admindu.de>
References: <1151740200.5540.7.camel@chronos> <1151914665.5505.7.camel@chronos>
In-Reply-To: <1151914665.5505.7.camel@chronos>
MIME-Version: 1.0
Content-Disposition: inline
Subject: Re: [uml-devel] [uml-user] Kernel panic - not syncing: Kernel mode
	signal 7	(with 2.6.17.1 and .2)
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
To: Stefan Hofmann <sh@luci.de>
Cc: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net

Hi,

Quoting Stefan Hofmann <sh@luci.de>:

> Am Samstag, den 01.07.2006, 09:49 +0200 schrieb Stefan Hofmann:
>
> Hi *,
>
>> after upgrading my (host + guest) debian system to 2.6.17.2, I often get
>> an uml kernel panic like this:
>
> can anyone help me, please? My systems run very dirty and I cannot use
> any 2.6.17.x kernels. Am I alone with this problem? Under 2.6.16.20 I
> never saw such a kernel panic.

I had similar looking panics and in my case it was a problem with  
tmpfs running out of space. tmpfs can be in various locations. In my  
case /dev/shm was used and it was far to small. I found that out using  
lsof and grepping for my UML instances.

hope this helps

               Daniel


Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
