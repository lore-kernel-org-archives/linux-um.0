Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Message-ID: <267988DEACEC5A4D86D5FCD780313FBB0349E09D@exch-03.noida.hcltech.com>
From: "Adil  Mujeeb, Noida" <adilm@hcltech.com>
Subject: RE: [uml-devel] bridge query
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
Date: Fri, 7 Jan 2005 20:42:30 +0530
To: user-mode-linux-user@lists.sourceforge.net
Cc: user-mode-linux-devel@lists.sourceforge.net


-----Original Message-----
From: Paul Warren [mailto:pdw@sphinx.mythic-beasts.com]On Behalf Of Paul
Warren
Sent: Friday, January 07, 2005 8:39 PM
To: Adil Mujeeb, Noida
Cc: user-mode-linux-devel@lists.sourceforge.net;
user-mode-linux-user@lists.sourceforge.net
Subject: Re: [uml-devel] bridge query


>[ follow up to -user only ]

>On Fri, Jan 07, 2005 at 08:25:58PM +0530, Adil  Mujeeb, Noida wrote:
>> what is the use of attaching the host interface in the bridge? Without
>> attaching the host interface in the bridge we can simply bring down the
host
>> interface with ip 0.0.0.0 & assign the host interface ip to the bridge.
>> What is the significance of attaching the host interface to the bridge
any
>> specific reason??
>
>If you do not add the host interface to the bridge, then guests
>connected to the bridge will not have access to the external network.
>In order for the bridge to pass packets to particular networks (e.g. the
>ethernet network connected to eth0) the interface connected to that
>network must be part of the bridge.

I have not added the guest interface & add a new ip to bridge and update the
routing tables and iam able to outside thru guest. Also if i attach the host
interface & assign the ip of host interface, still i need to update the
routing table. So whats the difference???

Regards,
Adil



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
