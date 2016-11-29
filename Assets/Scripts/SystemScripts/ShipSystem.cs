
using UnityEngine;
using System.Collections;
using System;

public class ShipSystem : Engineer {
    AudioSource breakStuff;

    Repair repairScript;
    [HideInInspector]
    public ShipController sc;
    public bool broken { get; private set; }
    public bool interacting { get; private set; }
    public bool unbreakable;

    // Use this for initialization
    virtual protected void Start() {
        repairScript = GetComponentInChildren<Repair>();
        broken = false;
        interacting = false;
        breakStuff = GetComponentInParent<AudioSource>();
    }

    public void StartInteraction() {
        interacting = true;
    }
    public void EndInteraction() {
        interacting = false;
    }

    public void Fixed() {
        broken = false;
        ResetHealth();
    }

    virtual protected void Break() {
        broken = true;
        repairScript.SetBroken();
        breakStuff.Play();
        //eController.Vibrate(100.0f);
        //sc.BreakVibration();
    }

    public int health { get; protected set; }

    public void TakeDamage(int damage) {
        if (unbreakable || health == 0)
            return;

        health -= damage;
        if (health <= 0) {
            health = 0;
            Break();
        }
    }

    protected virtual void ResetHealth() { }

}
