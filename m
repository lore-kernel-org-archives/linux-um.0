Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B1uX1-0008Sq-Da for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Mar 2004 13:49:27 -0800
Received: from fep01-0.kolumbus.fi ([193.229.0.41] helo=fep01-app.kolumbus.fi)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1B1tnt-0005q0-Cc for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Mar 2004 13:02:49 -0800
Message-ID: <40522BEB.5060104@kolumbus.fi>
From: Sakari Ailus <sakari.ailus@kolumbus.fi>
MIME-Version: 1.0
Subject: Re: [uml-devel] 2.6 UML Kernel Woes (re UDB Device)
References: <Pine.LNX.4.44.0403100234590.6567-200000@pluto2.express.org>
In-Reply-To: <Pine.LNX.4.44.0403100234590.6567-200000@pluto2.express.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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
Date: Fri, 12 Mar 2004 23:30:19 +0200
To: "William R. Lorenz" <wrl@express.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

William R. Lorenz wrote:
> When I run the 2.6.3 binary, I get the following error to the console:
> 
>   VFS: Cannot open root device "ubd0" or unknown-block(0,0)
>   Please append a correct "root=" boot option
>   Kernel panic: VFS: Unable to mount root fs on unknown-block(0,0)

I also started seeing this with 2.6.4-um1. 2.6.0-um1 was ok.

>     eth0=tuntap,tap3 root=/dev/ubd0

Apparently you can also give root device directly as major/minor pair, 
i.e. root=98:0 in this case. There have been suggestions to change 
/dev/ubd0 to /dev/ubd/0, but in my case that didn't work, I have no idea 
why. Anyway; as the default device is ubd0, root is not even needed... :)

-- 
Sakari Ailus
sakari.ailus@kolumbus.fi


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
