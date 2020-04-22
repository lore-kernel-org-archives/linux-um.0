Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jRFp3-0001Qn-Lw
 for linux-um@lists.infradead.org; Wed, 22 Apr 2020 13:53:55 +0000
Subject: Re: UML HowTo rewrite
References: <7fbb1a33-5fed-6c61-6c2a-ca47932669a7@cambridgegreys.com>
 <6d00f01fa378b5cb9273e05ab90adc58f6c6ab8f.camel@sipsolutions.net>
 <1a7a4aa7-aa01-9747-202a-b93ffb5c657a@cambridgegreys.com>
 <cbf1b59a-e6d5-5870-76dc-60455fb179fa@cambridgegreys.com>
 <28e23bdd281be6368ed75883ca73ea57de4faaad.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <6fd55233-8fd0-4ec3-7481-b303f79bda8d@cambridgegreys.com>
Date: Wed, 22 Apr 2020 14:53:49 +0100
MIME-Version: 1.0
In-Reply-To: <28e23bdd281be6368ed75883ca73ea57de4faaad.camel@sipsolutions.net>
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
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org

On 22/04/2020 14:47, Johannes Berg wrote:
> On Wed, 2020-04-22 at 14:30 +0100, Anton Ivanov wrote:
>> The initial content is more or less in place.
> Great. I actually saw it (you posted a link to a PR before) and pointed
> a colleague who was interested in what I'm doing with all my time-travel
> simulation and UML to it. I told him feedback would surely be welcome :)
>
>> Comments and PRs to change/add things are welcome.
>>
>> https://github.com/kot-begemot-uk/uml-howto-v2
> Are you going to submit it to the Documentation/ folder in the kernel?

Yes. A couple of revisions, reviews and PRs first though :)

>
> I'd much prefer to contribute changes to the kernel after it lands
> there, otherwise I'd have to jump through (legal) approval hoops ...

Easier to deal with the early "high flux" change rate when it is out of 
tree.

>
>
> Btw, one thing that I think is useful to document is how to run
> *without* an image - you don't need a full OS inside. Most of my use
> cases just run something like
>
> ./linux mem=256M root=none hostfs=/ rootfstype=hostfs rootflags=/ init=/some/script.sh

hostfs and hostfs use as root is in the Advanced section.

As I do not use it, can you review it (it is mostly copied from the old 
howto).

IMHO hostfs can be significantly improved by using inotify. It has been 
on my TODO list for a while now.

>
> Would be a worthwhile addition, I think?
>
> Anyway, like I said above, I'm happy to contribute to this but would
> prefer if it's in the kernel first.

I have a little bit more content to add to the Developing section, but as I said - I am happy to do it after we add it to the tree if everyone thinks that this is better.

>
> johannes
>
>
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um
>

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

