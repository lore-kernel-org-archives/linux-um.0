Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Henrik Nordstrom <uml@hno.marasystems.com>
Subject: RE: [uml-devel] bridge query
In-Reply-To: <267988DEACEC5A4D86D5FCD780313FBB0349E09D@exch-03.noida.hcltech.com>
Message-ID: <Pine.LNX.4.61.0501071746110.8358@filer.marasystems.com>
References: <267988DEACEC5A4D86D5FCD780313FBB0349E09D@exch-03.noida.hcltech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
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
Date: Fri, 7 Jan 2005 17:47:50 +0100 (CET)
To: "Adil  Mujeeb, Noida" <adilm@hcltech.com>
Cc: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

On Fri, 7 Jan 2005, Adil  Mujeeb, Noida wrote:

> I have not added the guest interface & add a new ip to bridge and update the
> routing tables and iam able to outside thru guest.

Correct.

You only need to use bridgeing if you want your UMLs to be part of the 
local lan where the host is connected, not for using the host as router 
(including proxy-arp router) to the LAN. For routing type setups it is 
sufficient to set up a TUN/TAP interface on the host.

Regards
Henrik


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
