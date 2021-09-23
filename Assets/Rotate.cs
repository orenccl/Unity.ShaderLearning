using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Rotate : MonoBehaviour
{
    [SerializeField] float rotateRate = 2;
    // Update is called once per frame
    void Update()
    {
        transform.Rotate(0, rotateRate * Time.deltaTime, 0);
    }
}
