Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D9pRg-0007a3-4k for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 11 Mar 2005 11:05:12 -0800
Received: from zcars04f.nortelnetworks.com ([47.129.242.57])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D9pRd-0003gT-JE for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 11 Mar 2005 11:05:12 -0800
Message-ID: <4231EBC7.9050901@nortel.com>
From: Chris Friesen <cfriesen@nortel.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] [PATCH 3/9] UML - "Hardware" random number generator
References: <200503100215.j2A2FuDN015227@ccure.user-mode-linux.org>
	<200503101341.37346.rob@landley.net>
	<200503111845.j2BIjkJp003341@ccure.user-mode-linux.org>
In-Reply-To: <200503111845.j2BIjkJp003341@ccure.user-mode-linux.org>
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
Date: Fri, 11 Mar 2005 13:04:39 -0600
To: Jeff Dike <jdike@addtoit.com>
Cc: Rob Landley <rob@landley.net>, user-mode-linux-devel@lists.sourceforge.net, akpm@osdl.org, linux-kernel@vger.kernel.org

Jeff Dike wrote:
> rob@landley.net said:
> 
>>I'm just thinking about those UML hosting farms, with several UML
>>instances  per machine, on machines which haven't got a keyboard
>>attached constantly  feeding entropy into the pool.

That's when you set the network links to feed entropy.  It may not be 
very good entropy, but it's probably better than nothing (especially in 
a UML virtual-system instance, where the real NIC is handling traffic 
for all hosted systems).

Chris


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
