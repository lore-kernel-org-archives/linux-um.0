Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DtT07-00032e-WA	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 15 Jul 2005 09:25:23 -0700
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.44)
	id 1DtT06-0004Ue-Ka	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 15 Jul 2005 09:25:24 -0700
Message-ID: <42D7E36E.1060605@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Am I doing something wrong with -skas0?
References: <200507122346.40320.rob@landley.net>
	<200507141316.38969.rob@landley.net> <200507141530.11249.rob@landley.net>
	<200507151810.39548.blaisorblade@yahoo.it>
In-Reply-To: <200507151810.39548.blaisorblade@yahoo.it>
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
Date: Fri, 15 Jul 2005 18:25:18 +0200
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Rob Landley <rob@landley.net>

Blaisorblade wrote:
> On Thursday 14 July 2005 22:30, Rob Landley wrote:
> 
>>On Thursday 14 July 2005 13:16, Rob Landley wrote:
>>
>>>Bodo's patch seems to have fixed the problem (albeit in a way that
>>>reveals ubuntu is using thread-local storage, so I can't use it anyway).
>>
>>Hang on a sec, if TLS is screwing up -skas0, then why does -tt mode work?
>>
>>Is this expected?
> 
> Hmm, I've seen TLS falling back on modify_ldt() at times, and it's surely a 
> bit bogus in current trees (although I have a partial fix for it, but not 
> sure whether it will work). Do you think init=/usr/bin/strace /bin/ls would 
> work? Uncomprehensible kernel params are passed to init, so it could.
Testing SKAS0 some month ago, I had problems with TLS in LDT, too. It didn't
print any message, but the processes looped on a segfault.
Debugging this, I changed SKAS0 to use the full faultinfo, so in the newer
versions it detects that the fault isn't fixable and generates SIGSEGV.
But I also had to add some code to make sys_modify_ldt work in SKAS0 (reading
and writing).

Most of this is in skas-hold-own-ldt, but further patches (e.g. skas0-clone)
might be necessary. The patches can be found in Jeff's incrementals.

	Bodo


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
