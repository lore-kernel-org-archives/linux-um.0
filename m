Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CHmLd-0005cH-B0 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Oct 2004 09:51:33 -0700
Received: from plam.fujitsu-siemens.com ([217.115.66.9])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CHmKb-000160-CV for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Oct 2004 09:51:33 -0700
Message-ID: <416D5CDA.9030007@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
References: <200410081635.i98GZgr02277@trolli.pdb.fsc.net>
	<200410122343.i9CNh03P004317@ccure.user-mode-linux.org>
In-Reply-To: <200410122343.i9CNh03P004317@ccure.user-mode-linux.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: Inconsistency in incremental patches 2.6.9
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
Date: Wed, 13 Oct 2004 18:50:34 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: bodo.stroesser@fujitsu-siemens.com, user-mode-linux-devel@lists.sourceforge.net

Jeff Dike wrote:
> bodo.stroesser@fujitsu-siemens.com said:
> 
>>The incremental patches for 2.6.9 do not fully apply. Before
>>"signal-interface-cleaning" this patch is missing: 
> 
> 
> That's in the signal_cleanup patch.  Am I missing something?
> 
> 				Jeff
> 
No. I was wrong. I used an old version of the signal_cleanup patch.

Sorry!

Bodo


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
