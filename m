Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CEad5-0006hD-Vn for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 Oct 2004 14:44:23 -0700
Received: from bay22-f38.bay22.hotmail.com ([64.4.16.88] helo=hotmail.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CEacz-0000dl-68 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 Oct 2004 14:44:23 -0700
From: "Young K" <young_uml@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY22-F38Fm15k4R9xC00023711@hotmail.com>
Subject: [uml-devel] slow execution in uml?
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
Date: Mon, 04 Oct 2004 17:35:00 -0400
To: user-mode-linux-devel@lists.sourceforge.net

hi, folks,

i was comparing uml network performance with genuine linux. the experiment i 
did was to insert time-stamping code in network stack, and see how slower 
uml is. i was sending 32-byte udp packets to another machine every 10 msec, 
and used rdtsc to measure the elapsed cpu cycles between sendto() and 
nf_hook_slow() (which is called inside ip_build_xmit()).

what i found was that it took around 29,000 cycles from sendto() to 
nf_hook_slow() in uml whereas only 2,000 cycles in genuine linux. it looks 
like a big difference. but i think it's purely code execution without any 
I/O operation between sendto() to nf_hook_slow(). then, why is it so slow in 
uml? is there any possible factors that make uml slower? (more cache 
misses?)

i used 2.4.22 for guest os(tt mode) and 2.4.25 for host os, but numbers were 
pretty much the same when i used other versions of 2.4 kernels for both 
guest and host. the computer i used for test was P4 2.2 GHz single processor 
with 512MB, FYI.

_________________________________________________________________
Check out Election 2004 for up-to-date election news, plus voter tools and 
more! http://special.msn.com/msn/election2004.armx



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
