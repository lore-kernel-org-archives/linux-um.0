Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by casper.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHiQ0-0063JF-J3
 for linux-um@lists.infradead.org; Thu, 04 Mar 2021 07:29:12 +0000
Subject: Re: linux uml segfault
References: <3448a70e7a39b9c3202aeefa7858ace265b8a978.camel@debian.org>
 <6d37b5aa-36f2-1fce-b70b-8faa0ff882e0@kot-begemot.co.uk>
 <c8bb257c-1542-12f5-89f1-5c1f14b8a70a@collabora.com>
 <db40449e-6916-56bf-377c-01b042b9c890@kot-begemot.co.uk>
 <529cd4e2f39efffb18125dffab3058aeec3351ce.camel@debian.org>
 <573e256a-990b-ddf6-7965-367bb8b21229@kot-begemot.co.uk>
 <1bdedf3c60058e1ae242a2a7f16eee256b0be3e0.camel@debian.org>
 <6370b92a-84fa-aa21-4270-fcaf1bf42407@kot-begemot.co.uk>
 <02e348bbb13f0fac92f2147309fb1c006b4583b2.camel@debian.org>
 <5ee28b97-6111-e12c-d0e9-83a13f2151ce@kot-begemot.co.uk>
 <5e068447e2067fff8b21c0689f14d080b984f6e0.camel@debian.org>
 <01a1b3551284a39a3c06ab2ec0222cbf6099a537.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <ab49a750-cc27-bec2-828b-1e4ce232c5a1@kot-begemot.co.uk>
Date: Thu, 4 Mar 2021 07:28:54 +0000
MIME-Version: 1.0
In-Reply-To: <01a1b3551284a39a3c06ab2ec0222cbf6099a537.camel@sipsolutions.net>
Content-Language: en-US
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Johannes Berg <johannes@sipsolutions.net>, rrs@debian.org, Christopher Obbard <chris.obbard@collabora.com>, "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>
Cc: 983379@bugs.debian.org

On 03/03/2021 22:40, Johannes Berg wrote:
> I think the problem is here:
> 
>> #24 0x000000006080f234 in ipc_init_ids (ids=0x60c60de8 <init_ipc_ns+8>)
>> at ipc/util.c:119
>> #25 0x0000000060813c6d in sem_init_ns (ns=0x60d895bb <textbuf+91>) at
>> ipc/sem.c:254
>> #26 0x0000000060015b5d in sem_init () at ipc/sem.c:268
>> #27 0x00007f89906d92f7 in ?? () from /lib/x86_64-linux-
>> gnu/libcom_err.so.2
> 
> You're in the init of libcom_err.so.2, which is loaded by
> 
>> "libnss_nis.so.2"
> 
> which is loaded by normal NSS code (getgrnam):
> 
>> #40 0x00007f89909bf3a6 in nss_load_library (ni=ni@entry=0x61497db0) at
>> nsswitch.c:359
>> #41 0x00007f89909bfc39 in __GI___nss_lookup_function (ni=0x61497db0,
>> fct_name=<optimized out>, fct_name@entry=0x7f899089b020 "setgrent") at
>> nsswitch.c:467
>> #42 0x00007f899089554b in init_nss_interface () at nss_compat/compat-
>> grp.c:83
>> #43 init_nss_interface () at nss_compat/compat-grp.c:79
>> #44 0x00007f8990895e35 in _nss_compat_getgrnam_r (name=0x7f8990a2a1e0
>> "tty", grp=0x7ffe3e7a2910, buffer=0x7ffe3e7a24e0 "", buflen=1024,
>> errnop=0x7f899089eb00) at nss_compat/compat-grp.c:486
>> #45 0x00007f8990968b85 in __getgrnam_r (name=name@entry=0x7f8990a2a1e0
>> "tty", resbuf=resbuf@entry=0x7ffe3e7a2910,
>> buffer=buffer@entry=0x7ffe3e7a24e0 "", buflen=1024,
>> result=result@entry=0x7ffe3e7a2908)
>>      at ../nss/getXXbyYY_r.c:315
> 
> 
> You have a strange nsswitch configuration that causes all of this
> (libnss_nis.so.2 -> libcom_err.so.2) to get loaded.
> 
> Now libcom_err.so.2 is trying to call sem_init(), and that gets ... tada
> ... Linux's sem_init() instead of libpthread's.
> 
> And then the crash.
> 
> Now, I don't know how to fix it (short of changing your nsswitch
> configuration) - maybe we could somehow rename sem_init()? Or maybe we
> can somehow give the kernel binary a lower symbol resolution than the
> libc/libpthread.

I have not looked in depth in how the linking process works, but it 
should have picked up the sem_init from the kernel library, not libc.

We are already supposed to do that regarding kernel vs libc string.h 
functions - memcpy, etc.

Though for all of them the libc does the same so invoking the wrong one 
does not kill you so this may have been broken for a while and we were 
simply not noticing it.

> 
> 
> johannes
> 
> 


-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

