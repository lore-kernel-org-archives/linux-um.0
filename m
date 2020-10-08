Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kQVNB-0005sp-6H
 for linux-um@lists.infradead.org; Thu, 08 Oct 2020 12:50:18 +0000
Subject: Re: [RFC v7 00/21] Unifying LKL into UML
References: <cover.1600922528.git.thehajime@gmail.com>
 <cover.1601960644.git.thehajime@gmail.com>
 <1ba41b09-6bdb-2fb7-5696-7db429e0a6a5@cambridgegreys.com>
 <m2362o6hmv.wl-thehajime@gmail.com>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <003d0714-3bb6-dc02-ba3d-0237f8c5f40c@cambridgegreys.com>
Date: Thu, 8 Oct 2020 13:50:08 +0100
MIME-Version: 1.0
In-Reply-To: <m2362o6hmv.wl-thehajime@gmail.com>
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
To: Hajime Tazaki <thehajime@gmail.com>
Cc: linux-arch@vger.kernel.org, tavi.purdila@gmail.com, richard@nod.at, jdike@addtoit.com, linux-um@lists.infradead.org, retrage01@gmail.com, linux-kernel-library@freelists.org


On 08/10/2020 13:12, Hajime Tazaki wrote:
> Hello Anton,
>
> On Wed, 07 Oct 2020 22:30:03 +0900,
> Anton Ivanov wrote:
>>
>> On 06/10/2020 10:44, Hajime Tazaki wrote:
>>> This is another spin of the unification of LKL into UML.  Based on the
>>> discussion of v4 patchset, we have tried to address issue raised and
>>> rewrote the patchset from scratch.  The summary is listed in the
>>> changelog below.
>>>
>>> Although there are still bugs in the patchset, we'd like to ask your
>>> opinions on the design we changed.
>>>
>>> The milestone section is also updated: this patchset is for the
>>> milestone 1, though the common init API is still not implemented yet.
>>>
>>>
>>> Changes in rfc v7:
>>> - preserve `make ARCH=um` syntax to build UML
>>> - introduce `make ARCH=um UMMODE=library` to build library mode
>>> - fix undefined symbols issue during modpost
>>> - clean up makefiles (arch/um, tools/um)
>> Hi Hajime, hi Tavi,
>>
>> Our starting point should be that it does not break the existing build. It still does.
> I agree with the starting point.
>
>> If I build a "stock configuration" UML after applying the patchset
>> the resulting vmlinux is not executable.
> Ah, I confirmed the issue.
> I was only trying to make the `linux` binary compatible, not vmlinux.
>
> Because vmlinux is now build as a relocatable object, this is
> something we need to figure out if we wish to keep vmlinux executable.
>
> Do you think we should make vmlinux executable even if we have the
> file linux executable ? If yes, we will work on this to fix the issue.

In my opinion, any relocatable objects, etc should be clearly named - either .o, .so, etc depending on what they are. We should not try to reuse any of the existing files for a different purpose.

I also agree with Johannes that we are not using the tools/ directory for its intended purpose.

We are not trying to build a tool. We are trying to build a sub-architecture. IMHO, the build should use a subdirectory under arch/um.

>> On the positive side, it builds cleanly now. I will try to go
>> through the rest of the patchset later today and see if there is
>> anything else that needs fixing before we do the next version.
> thanks for your time.
>
> -- Hajime
>
>
-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

