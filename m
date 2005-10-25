Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EUWoK-0004SA-0Z	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Oct 2005 14:58:24 -0700
Received: from rimuhosting.com ([69.90.33.248])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1EUWoH-0006L3-S2
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Oct 2005 14:58:24 -0700
Message-ID: <435EAA6E.6070107@rimuhosting.com>
From: Peter <peter.spamcatcher@rimuhosting.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] SKAS race condition status?
References: <43542ACC.7020108@theshore.net> <435E60F1.2010005@linode.com>
In-Reply-To: <435E60F1.2010005@linode.com>
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
Date: Wed, 26 Oct 2005 10:58:06 +1300
To: "Christopher S. Aker" <caker@linode.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, Blaisorblade <blaisorblade@yahoo.it>

I have skas3-v8 host servers with model 4 processes and good (100+ day) 
uptimes.  The host server I had issues with (host38) got converted to 
Xen and is still having problems.  I am seeing issues with host34 that 
require the odd restart.  That server runs the same CPU model and kernel 
code as other servers of mine with good uptime.

My conclusion is that I must be seeing hardware issues rather than a 
skas bug.

- Peter

# for ((i=34;i<41;i++)); do echo host$i $(ssh host$i 'echo $(cat 
/proc/cpuinfo  | grep model | grep -v name | head -n 1) $(uname -r) 
$(uptime)'); done
host34 model : 2 2.6.11.10-skas3-v8 21:52:37 up 15:19, 0 users, load 
average: 1.64, 1.60, 1.32
host35 model : 4 2.6.11.7-skas3-v8 21:49:21 up 42 days, 12:15, 0 users, 
load average: 13.72, 9.66, 5.21
host36 model : 4 2.6.11.12-skas3-v8.2 21:49:23 up 61 days, 0 min, 0 
users, load average: 1.26, 1.44, 1.78
host37 model : 4 2.6.11.7-skas3-v8 21:49:25 up 121 days, 9:48, 0 users, 
load average: 0.91, 1.04, 1.14
host38 model : 2 2.6.11.12-xen0 21:49:26 up 7 days, 13:28, 0 users, load 
average: 0.02, 0.05, 0.01
host39 model : 4 2.6.11.7-skas3-v8 21:49:28 up 106 days, 2:46, 0 users, 
load average: 0.59, 0.65, 0.70
host40 model : 4 2.6.11.7-skas3-v8 21:49:39 up 121 days, 9:47, 0 users, 
load average: 0.27, 0.43, 0.47


Christopher S. Aker wrote:
> Christopher S. Aker wrote:
> 
>> Has there been any progress on the race in SKAS?  I've been dealing 
>> with 2-4 hosts crashing a week.  Same thing happens on my old SKAS 
>> kernel, 2.6.7 with skas3-v4 or so.
> 
> 
> Jeff and I realized that this only happens on Xeon processors where the 
> model number is > 2.  None of my model 2 Xeon hosts crash, but my model 
> 3 and model 4 xeons do.  grep model /proc/cpuinfo for info.  I've had 
> skas3-v4 and skas3-v8.2 generate the same panic, so it's something 
> processor model specific.
> 
> Peter, can you verify the problems you've had are on hosts with a model 
> 3 or 4 Xeon processor?  Also, with regard to 2.6.12, I'm not sure we're 
> looking at the same issue, as I had problems with that kernel too but 
> wasn't able to verify it was the same panic.  I have had 2.6.13 working, 
> and it does generate the same SKAS panic eventually.
> 
> Thanks,
> -Chris


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
