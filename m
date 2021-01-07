Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kxVQD-0002jw-La
 for linux-um@lists.infradead.org; Thu, 07 Jan 2021 13:33:50 +0000
Subject: Re: Replacing a legacy uml-switch with bess
References: <78c472a8-741c-bdad-4e34-896bd968af5e@gmail.com>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <44225bda-b33e-7802-f127-13174398f888@cambridgegreys.com>
Date: Thu, 7 Jan 2021 12:58:16 +0000
MIME-Version: 1.0
In-Reply-To: <78c472a8-741c-bdad-4e34-896bd968af5e@gmail.com>
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
To: Joshua Hawking <joshuahawking1@gmail.com>, linux-um@lists.infradead.org

On 07/01/2021 12:31, Joshua Hawking wrote:
> Hi everyone,
> 
> I currently maintain a project called Netkit which facilitates network
> simulation using UML machines. This project is quite old and we've been
> working on upgrading it to a modern codebase.
> 
> Netkit relies on using uml_net for communication between the machines.
> It uses the legacy uml_switches to create hubs that connect to the
> machine, using the old ethX command line parameters. For example:
> 
> /home/josh/netkit-kernel
> --eth0=daemon,,,/home/josh/.netkit/vhub_Internet.cnct
> 
> where the vhub_Internet.cnct is the uml_switch socket. We're looking to
> upgrade this to use the new vector networking to utilize the better
> performance and remove legacy code that could break on a kernel update.
> 
> I've been looking at the linux kernel documentation that discusses using
> the Bess switch software to provide networking between UML machines.
> (https://github.com/torvalds/linux/blob/master/Documentation/virt/uml/user_mode_linux_howto_v2.rst#bess-socket-transport)
> 
> However, I can't find any good examples of using Bess with UML and was
> wondering whether anyone on the mailing list has any advice/examples.
> 
> I noted that Anton had submitted a PR to Bess to improve UML support and
> I was wondering whether this means that the build without this patch
> would not work with UML at all.
> 
> https://github.com/NetSys/bess/pull/1022
> 
> Hopefully someone may be able to point me in the right direction on
> handling uml_switch removal!

It will, but you need a fairly complex pipeline.

Basically, BESS replicator module which you need for BCAST/MCAST as well 
as flooding does not have a reflection check.

So f.e. 3 ports wired to a Replicator will not work.

As a result you cannot implement a simple shared switch and have to do a 
fully featured per-port pipeline with "drop to slow path for learning", 
implicit reflection checks, etc.

The workaround would be to have

inPort->L2Forwarding->Replicator

chain for each port and ensure that the Replicator is wired only to 
other ports in the same VLAN.

A.

> 
> Thanks,
> 
> Josh
> 
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

