Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DJFkN-0007wh-9I for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Apr 2005 11:59:27 -0700
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DJFkL-0002hZ-BW for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Apr 2005 11:59:26 -0700
Message-ID: <4254318B.1000500@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
References: <4253E3D6.2000809@fujitsu-siemens.com>
	<20050406203558.GA3307@ccure.user-mode-linux.org>
In-Reply-To: <20050406203558.GA3307@ccure.user-mode-linux.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: UML-patches to prepare UML/s390
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
Date: Wed, 06 Apr 2005 20:59:23 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux devel <user-mode-linux-devel@lists.sourceforge.net>

Jeff Dike wrote:
> On Wed, Apr 06, 2005 at 03:27:50PM +0200, Bodo Stroesser wrote:
> 
>>Here are the patches (tarball attached), that I've applied to
>>UML 2.6.11 + incrementals, before adding s390-files.
>>These patches are tested a bit on x86, but not on x86_64.
> 
> 
> I merged these, except for the restartnointr one because I don't have
> ERESTARTNOINTR in my /usr/include, inside a #ifdef KERNEL or not.
> 
> 				Jeff
And sorry, I forgot: Thank you for merging most of them!

	Bodo


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
