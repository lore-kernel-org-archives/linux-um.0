Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BEjEZ-0000ek-UR for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 Apr 2004 23:23:23 -0700
Received: from [207.44.234.19] (helo=cpanel.bh-link.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1BEjEZ-0000cw-JA
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 Apr 2004 23:23:23 -0700
Message-ID: <4080CD5B.50202@almahdi.cc>
From: Ali Almahdi <ali@almahdi.cc>
MIME-Version: 1.0
Subject: Re: [uml-devel] root password for root_fs_slack8.1 image?
References: <59953.192.168.0.23.1082173959.squirrel@hnsg.net>
	<4080AF6D.4030206@austin.rr.com>
In-Reply-To: <4080AF6D.4030206@austin.rr.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Sat, 17 Apr 2004 09:23:23 +0300
To: Steven Elliott <selliott4@austin.rr.com>
Cc: "Christopher J. Pace" <cpace@hnsg.net>, User Mode Linux Devel <user-mode-linux-devel@lists.sourceforge.net>

Steven Elliott wrote:

> Christopher J. Pace wrote:
>
>> Does anyone happen to know the root password for this image?  It isn't
>> root, none, slack, or anything else I could think of.  Please send to me
>> personally, as I'm not subscribed to this list.  Thanks to all.
>>  
>>
> I'm not sure what it is (have not tried that one), but you should be 
> able to mount the filesystem using the loop device:
>    mount -o loop /tmp/slack_fs /mnt/misc
> and then edit the password file in order to blank out the password for 
> root:
>    cd /mnt/misc/etc
>    vi passwd
>
You should change the password in shadow, not in the passwd...

Just change the unreadable text to nothing and the password will be blank..


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
