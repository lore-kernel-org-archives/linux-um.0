Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iHqJ3-0006xN-Pp
 for linux-um@lists.infradead.org; Tue, 08 Oct 2019 14:17:43 +0000
Subject: Re: [PATCH 2/2] um: drivers: Add virtio vhost-user driver
References: <20190731202942.29630-1-johannes@sipsolutions.net>
 <20190731202942.29630-2-johannes@sipsolutions.net>
 <50395b43-5952-0df5-b753-b3de4c246ed4@cambridgegreys.com>
 <8718663842671e3d825ccc8eef6f9669a5a85884.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <3cb5a05b-1b63-24e0-be1b-383c7b9230e0@cambridgegreys.com>
Date: Tue, 8 Oct 2019 15:17:33 +0100
MIME-Version: 1.0
In-Reply-To: <8718663842671e3d825ccc8eef6f9669a5a85884.camel@sipsolutions.net>
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
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
Cc: Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, Erel Geron <erelx.geron@intel.com>



On 08/10/2019 12:57, Johannes Berg wrote:
> On Tue, 2019-10-08 at 10:26 +0100, Anton Ivanov wrote:
> 
>> It just hit me - this violates UML security model.
> 
> Hmm.
> 
>> In UML (and any virtualization for that matter) the guest side is never
>> allowed to specify any paths, files, etc locations on the host side.
> 
> Yeah, I guess that makes sense.
> 
>> This driver accepts a path argument to a host side path being supplied
>> by the guest side.
> 
> Right, sort of.
> 
>> One way of getting around this will be to sort out what uml does for
>> iomem and make it generic and not just memory and just boot time.
>>
>> This way boot or uml_mconsole can supply a file id and a driver can
>> associate with this id.
> 
> Or maybe just not allow this to be a module? Then it cannot be loaded
> from inside, and the command-line must be given from outside, I think?
> We could change it to use __uml_setup() too.

That would do it.

> 
> Perhaps with kexec() it's possible to influence the next kernel's
> command line though, but that might already be an issue then?

It is an issue, if kexec works.

I do not quite see how UML memory set-up and initial setup will work if 
you try to kexec UML from UML.

In fact, you will need a specially built kernel to start with, the 
normal UML kernel build should not work.
> 
> johannes
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

